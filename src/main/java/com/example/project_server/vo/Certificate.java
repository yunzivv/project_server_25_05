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
	private int parendId;
	private int national;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
}
