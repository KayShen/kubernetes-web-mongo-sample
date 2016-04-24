package services;

import com.google.common.collect.ImmutableList;
import com.mongodb.DB;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.WriteConcern;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import play.Application;

import javax.inject.Inject;
import javax.inject.Singleton;

/**
 * Guestbook handling.
 */
@Singleton
public class MongoDB {
	private static final Logger log = LoggerFactory.getLogger(MongoDB.class);

	private final DB database;

	private final Application application;

	private final MongoClient mongoClient;

	@Inject
	public MongoDB(final Application application) {
		this.application = application;

		log.debug("Connecting to MongoDB " + application.configuration().getString("mongodb.address") +
				":" + application.configuration().getString("mongodb.port") +
				" using database " + application.configuration().getString("mongodb.database"));

		mongoClient = new MongoClient(
				ImmutableList.of(new ServerAddress(application.configuration().getString("mongodb.address"), application.configuration().getInt("db.mongodb.port"))));

		mongoClient.setWriteConcern(WriteConcern.ACKNOWLEDGED);
		this.database = mongoClient.getDB(application.configuration().getString("mongodb.database"));

	}

	public DB getDatabase() {
		return database;
	}

	public MongoClient getMongoClient() {
		return mongoClient;
	}
}
