package com.team.domain;

import java.util.Date;
import lombok.Data;

@Data
public class MessageVO {
    private long mno;
    private String writer;
    private String reader;
    private String content;
    private Date regdate;
  
}