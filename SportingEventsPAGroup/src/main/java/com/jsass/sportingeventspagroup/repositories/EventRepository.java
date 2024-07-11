package com.jsass.sportingeventspagroup.repositories;
import org.springframework.data.jpa.repository.JpaRepository;

import com.jsass.sportingeventspagroup.models.*;

public interface EventRepository extends JpaRepository<Event, Long> {
}