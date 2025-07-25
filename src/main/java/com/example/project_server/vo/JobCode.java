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
public class JobCode {

	private int id;
	private int jobCatId;
	private String jobCatName;
	private int code;
	private String name;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
}
