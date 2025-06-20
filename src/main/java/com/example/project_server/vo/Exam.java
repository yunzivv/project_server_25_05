package com.example.project_server.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Exam {

	private int id;
	private int certId;
	private String category;
	private LocalDate examDate;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;

	private String extra__certName;

	public Exam(int id, int certId, String extra__certName){
		this.id = id;
		this.certId = certId;
		this.extra__certName = extra__certName;
	}
}
