package services;

import com.google.common.collect.ImmutableList;
import com.mongodb.DB;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.WriteConcern;
import com.mongodb.client.MongoDatabase;
import com.typesafe.config.ConfigFactory;
import play.Application;

import javax.inject.Inject;
import javax.inject.Singleton;

/**
 * Guestbook handling.
 */
@Singleton
public class MongoDB {

	private final MongoDatabase database;

	private final Application application;

	@Inject
	public MongoDB(final Application application) {
		this.application = application;

		final MongoClient mongoClient = new MongoClient(
				ImmutableList.of(new ServerAddress(application.configuration().getString("db.mongodb.address"), 27017)));

		mongoClient.setWriteConcern(WriteConcern.ACKNOWLEDGED);
		this.database = mongoClient.getDatabase(application.configuration().getString("db.mongodb.database"));
	}

	public MongoDatabase getDatabase() {
		return database;
	}

}
