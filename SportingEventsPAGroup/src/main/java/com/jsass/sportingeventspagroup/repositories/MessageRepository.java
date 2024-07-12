package com.jsass.sportingeventspagroup.repositories;

import com.jsass.sportingeventspagroup.models.Message;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MessageRepository extends JpaRepository<Message, Long> {
}
