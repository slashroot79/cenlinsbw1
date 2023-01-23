package com.ragukar.cenlinsbw1.root;

import java.security.PublicKey;

import org.apache.catalina.util.ServerInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringBootVersion;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("")
public class RootController {
	
	@Value("${WEBSITE_HOSTNAME:raguapp}")
	private String sitename;
	@Value("${HOSTNAME:winbox}")
	private String machineName;
	
	@GetMapping("/")
	public String root() {
		return String.format("Hello from %s running on instance %s | Tomcat ver : %s | SpringBoot ver: %s", this.sitename,this.machineName, ServerInfo.getServerNumber().toString(), SpringBootVersion.getVersion().toString());
	}
	
	@GetMapping("/test")
	public String test() {
		return "test endpoint for endpoint test";
	}
}
