package com.example.project_server.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment {

	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String relTypeCode;
	private int relId;
	private String body;
	private int reactionPoint;

	private String extra__writer;

	private boolean userReaction;
	private boolean userCanModify;
	private boolean userCanDelete;

}