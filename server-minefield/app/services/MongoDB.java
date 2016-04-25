package services;

import com.google.common.collect.ImmutableList;
import com.mongodb.DB;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.WriteConcern;
import com.typesafe.config.ConfigFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.inject.Singleton;

/**
 * Guestbook handling.
 */
@Singleton
public class MongoDB {
	private static final Logger log = LoggerFactory.getLogger(MongoDB.class);

	private final DB database;

	private final MongoClient mongoClient;

	@Inject
	public MongoDB() {
		log.debug("Connecting to MongoDB " + ConfigFactory.load().getString("mongodb.address") +
				":" + ConfigFactory.load().getString("mongodb.port") +
				" using database " + ConfigFactory.load().getString("mongodb.database"));

		mongoClient = new MongoClient(
				ImmutableList.of(new ServerAddress(ConfigFactory.load().getString("mongodb.address"), ConfigFactory.load().getInt("mongodb.port"))));

		mongoClient.setWriteConcern(WriteConcern.ACKNOWLEDGED);
		this.database = mongoClient.getDB(ConfigFactory.load().getString("mongodb.database"));

	}

	public DB getDatabase() {
		return database;
	}

	public MongoClient getMongoClient() {
		return mongoClient;
	}
}
