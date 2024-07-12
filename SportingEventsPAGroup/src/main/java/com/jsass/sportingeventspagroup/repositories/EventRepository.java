package com.jsass.sportingeventspagroup.repositories;

import com.jsass.sportingeventspagroup.models.Event;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EventRepository extends CrudRepository<Event, Long> {
    Optional<Event> findById(Long id);

    List<Event> findAll();

    @Query("SELECT e FROM Event e LEFT JOIN FETCH e.attendees WHERE e.id = ?1")
    Optional<Event> findByIdWithAttendees(Long id);
}
