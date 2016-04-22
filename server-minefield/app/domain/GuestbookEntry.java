/**
 * This file is part of the source code and related artifacts for eGym Application.
 * <p>
 * Copyright © 2013 eGym GmbH
 */
package domain;

import org.mongojack.ObjectId;

/**
 * Common JSON property names should be placed here.
 */
public class GuestbookEntry {

	@ObjectId
	private String id;

	private Long timestampCreation;

	private Long timestampUpdate;

	private String alias;

	private String text;

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

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
}
