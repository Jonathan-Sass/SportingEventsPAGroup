package com.jsass.sportingeventspagroup.repositories;

import com.jsass.sportingeventspagroup.models.Event;
import com.jsass.sportingeventspagroup.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByCreatorOrAttendeesContains(User creator, User attendee);
}
