/**
 * This file is part of the source code and related artifacts for eGym Application.
 *
 * Copyright © 2013 eGym GmbH
 */
package dao;

import com.mongodb.DB;
import com.mongodb.MongoClient;
import org.mongojack.DBQuery;
import org.mongojack.JacksonDBCollection;
import org.mongojack.WriteResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.util.List;

/**
 * Base class for all DAOs.
 */
abstract class AbstractDao<T> implements Dao<T> {
	private static final Logger log = LoggerFactory.getLogger(AbstractDao.class);

	private final DB db;

	protected AbstractDao(final DB database, final MongoClient mongoClient) {
		if (mongoClient == null || database == null) {
			throw new IllegalArgumentException("mongoClient and databaseName must not be null.");
		}

		log.info("databaseName: " + database.getName());
		this.db = database;
	}

	protected DB getDb() {
		return db;
	}

	@Override
	public long countAll() {
		return getDbCollection().count();
	}

	@Override
	public void deleteAll() {
		getDbCollection().drop();
		/* Recreate the indices after everything is deleted. */
		createIndexes();
	}

	@Nonnull
	@Override
	public List<T> findAll() {
		return getDbCollection().find().toArray();
	}

	@Override
	public T saveAndDeserialize(@Nonnull final T entity) {
		WriteResult<T, String> result = getDbCollection().save(entity);
		return result.getSavedObject();
	}

	@Override
	public String save(@Nonnull final T entity) {
		WriteResult<T, String> result = getDbCollection().save(entity);
		return result.getSavedId();
	}

	/**
	 * Method currently not supported because it requires the id property in the entity to be annotated with {@link org.mongojack.ObjectId}.
	 *
	 * @param id the entity ID. Must not be <code>null</code>.
	 * @return the entity with the specified ID
	 */
	@Nullable
	@Override
	public T findById(@Nonnull final String id) {
		try {
			return getDbCollection().findOneById(id);
		} catch (IllegalArgumentException e) {
			// This exception is thrown by the mongo driver if the id is an invalid ObjectId (@see ObjectId.isValid)
			return null;
		}
	}

	protected abstract JacksonDBCollection<T, String> getDbCollection();


	@Nullable
	public T upsertByQuery(@Nonnull final DBQuery.Query query, @Nonnull final T object) {

		// This performs a search query with an update with write lock in mongo db.
		return getDbCollection().findAndModify(query, null, null, false, object, true, true);
	}
}
