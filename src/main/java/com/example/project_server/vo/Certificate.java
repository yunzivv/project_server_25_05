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
public class Certificate {

	private int id;
	private String name;
	private int parentId;
	private int isNational;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;

	private int extra__certCount;

	private int extra__certType;
	private int extra__certCountByType;

	public Certificate(int id, String name){
		this.id = id;
		this.name = name;
	}
}
