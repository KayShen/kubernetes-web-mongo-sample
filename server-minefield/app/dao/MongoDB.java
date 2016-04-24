package dao;

import com.google.common.collect.ImmutableList;
import com.mongodb.DB;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.WriteConcern;
import play.Application;

import javax.inject.Inject;
import javax.inject.Singleton;

/**
 * Guestbook handling.
 */
@Singleton
public class MongoDB {

	private final DB database;

	private final Application application;

	@Inject
	public MongoDB(final Application application) {
		this.application = application;

		final MongoClient mongoClient = new MongoClient(
				ImmutableList.of(new ServerAddress(application.configuration().getString("db.mongodb.address"), application.configuration().getInt("db.mongodb.port"))));

		mongoClient.setWriteConcern(WriteConcern.ACKNOWLEDGED);
		this.database = mongoClient.getDB(application.configuration().getString("db.mongodb.database"));
	}

	public DB getDatabase() {
		return database;
	}

}
