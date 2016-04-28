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

		final int port = ConfigFactory.load().getInt("mongodb.port");
		final String host = ConfigFactory.load().getString("mongodb.host");
		final String database = ConfigFactory.load().getString("mongodb.database");

		log.debug("Connecting to MongoDB instance or cluster with host " + host + ":" + port +
				" using database " + database);

		this.mongoClient = new MongoClient(ImmutableList.of(new ServerAddress(host, port)));

		this.mongoClient.setWriteConcern(WriteConcern.ACKNOWLEDGED);
		this.database = mongoClient.getDB(ConfigFactory.load().getString("mongodb.database"));
	}

	public DB getDatabase() {
		return database;
	}

	public MongoClient getMongoClient() {
		return mongoClient;
	}
}
