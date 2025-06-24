package com.example.project_server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
public class project_serverApplication {

	public static void main(String[] args) {
		SpringApplication.run(project_serverApplication.class, args);
	}

	@SpringBootApplication
	@EnableScheduling
	public class ProjectServerApplication {
		public static void main(String[] args) {
			SpringApplication.run(ProjectServerApplication.class, args);
		}
	}

}
