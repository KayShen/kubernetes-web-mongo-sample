/**
 * This file is part of the source code and related artifacts for eGym Application.
 * <p>
 * Copyright © 2013 eGym GmbH
 */
package domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.mongojack.ObjectId;
import play.data.validation.Constraints;

/**
 * Common JSON property names should be placed here.
 */
public class GuestbookEntry {

	@ObjectId
	@JsonProperty(value = "_id", required = false)
	private String id;

	private Long timestampCreation;

	private Long timestampUpdate;

	@Constraints.Required
	@Constraints.MinLength(2)
	private String alias;

	@Constraints.Required
	@Constraints.MinLength(2)
	private String message;

	private String color;

	public Long getTimestampCreation() {
		return timestampCreation;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setTimestampCreation(Long timestampCreation) {
		this.timestampCreation = timestampCreation;
	}

	public Long getTimestampUpdate() {
		return timestampUpdate;
	}

	public void setTimestampUpdate(Long timestampUpdate) {
		this.timestampUpdate = timestampUpdate;
	}

	public String getAlias() {
		return alias;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}


	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
}
