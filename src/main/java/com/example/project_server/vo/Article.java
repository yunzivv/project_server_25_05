package com.example.project_server.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class  Article {

	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private int boardId;
	private String title;
	private String body;
	private int hits;

	private int extra__sumReaction;
	private int extra__sumComment;
	private String extra__writer;
	private String extra__boardCode;

	private boolean userCanModify;
	private boolean userCanDelete;
	private boolean userReaction;

	public Article(String title, String body, int memberId, int boardId) {
		this.title = title;
		this.body = body;
		this.memberId = memberId;
		this.boardId = boardId;
	}
}
