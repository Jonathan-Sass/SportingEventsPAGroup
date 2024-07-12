package com.jsass.sportingeventspagroup.services;

import com.jsass.sportingeventspagroup.models.Message;
import com.jsass.sportingeventspagroup.repositories.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MessageService {

    @Autowired
    private MessageRepository messageRepository;

    public Message saveMessage(Message message) {
        return messageRepository.save(message);
    }

    public Optional<Message> findMessageById(Long id) {
        return messageRepository.findById(id);
    }

    public void deleteMessageById(Long id) {
        messageRepository.deleteById(id);
    }
}
