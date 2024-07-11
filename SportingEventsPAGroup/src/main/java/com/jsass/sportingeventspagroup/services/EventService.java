package com.jsass.sportingeventspagroup.services;

import com.jsass.sportingeventspagroup.models.*;
import com.jsass.sportingeventspagroup.repositories.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class EventService {
    @Autowired
    private EventRepository eventRepository;

    public Event saveEvent(Event event) {
        return eventRepository.save(event);
    }

    public List<Event> findAllEvents() {
        return eventRepository.findAll();
    }

    public Optional<Event> findEventById(Long id) {
        return eventRepository.findById(id);
    }

    public void deleteEventById(Long id) {
        eventRepository.deleteById(id);
    }

    // Additional methods can go here
}