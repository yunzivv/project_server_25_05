package com.example.project_server.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class JobCat {

	private int id;
	private String name;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;

	private int extra__jobCatMentionCount;

	public JobCat(int id, String name, int extra__jobCatMentionCount) {
		this.id = id;
		this.name = name;
		this.extra__jobCatMentionCount = extra__jobCatMentionCount;
	}
}
