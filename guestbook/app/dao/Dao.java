/**
 * This file is part of the source code and related artifacts for eGym Application.
 *
 * Copyright © 2013 eGym GmbH
 */
package dao;

import javax.annotation.Nonnull;
import java.util.List;

/**
 * Base interface for all data access objects. Each concrete implementation manages one collection in the database.
 *
 * @param <T>
 *            the type of the entity
 */
public interface Dao<T> {
	/**
	 * Counts all objects of the collection managed by the concrete implementation.
	 *
	 * @return number of elements in the collection.
	 */
	long countAll();

	/**
	 * Removes all elements from the collection.
	 */
	void deleteAll();

	/**
	 * Finds all elements in the collections.
	 *
	 * @return all elements in the collection
	 */
	List<T> findAll();

	/**
	 * Persists the specified entity and returns its associated database id.
	 *
	 * @param entity
	 *            the entity to persist. Must not be <code>null</code>.
	 * @return the saved object - this could be a little bit slow, since it deserializes the object. If you require only the id call
	 *         {@link #save(Object)} instead.
	 */
	T saveAndDeserialize(@Nonnull T entity);

	/**
	 * Persists the specified entity and returns its associated database id.
	 *
	 * @param entity
	 *            the entity to persist. Must not be <code>null</code>.
	 * @return the saved object's id.
	 */
	String save(@Nonnull T entity);

	/**
	 * Finds the entity with the specified ID.
	 *
	 * @param id
	 *            the entity ID. Must not be <code>null</code>.
	 * @return the entity with the specified ID
	 */
	T findById(@Nonnull String id);

	/**
	 * Creates all indices for the associated collection. This method is idempotent.
	 */
	void createIndexes();
}
