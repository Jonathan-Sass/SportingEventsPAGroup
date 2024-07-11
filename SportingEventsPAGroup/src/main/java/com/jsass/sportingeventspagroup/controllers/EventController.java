package com.jsass.sportingeventspagroup.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.jsass.sportingeventspagroup.models.*;
import com.jsass.sportingeventspagroup.services.*;

import java.security.Principal;
import java.util.Optional;

@Controller
@RequestMapping("/events")
public class EventController {
    @Autowired
    private EventService eventService;

    @Autowired
    private UserService userService;

    @GetMapping
    public String listEvents(Model model) {
        model.addAttribute("events", eventService.findAllEvents());
        return "search";
    }

    @GetMapping("/{id}")
    public String viewEvent(@PathVariable Long id, Model model) {
        Optional<Event> event = eventService.findEventById(id);
        event.ifPresent(value -> model.addAttribute("event", value));
        return "viewEvent";
    }

    @GetMapping("/new")
    public String showEventForm(Model model) {
        model.addAttribute("event", new Event());
        return "createEvent";
    }

    @PostMapping("/create")
    public String createEvent(@ModelAttribute("event") Event event, Principal principal) {
        if (principal != null) {
            Optional<User> user = userService.findUserByEmail(principal.getName());
            user.ifPresent(event::setCreator);
        }
        eventService.saveEvent(event);
        return "redirect:/events";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        Optional<Event> event = eventService.findEventById(id);
        event.ifPresent(value -> model.addAttribute("event", value));
        return "editEvent";
    }

    @PostMapping("/{id}/update")
    public String updateEvent(@PathVariable Long id, @ModelAttribute("event") Event event) {
        Optional<Event> existingEvent = eventService.findEventById(id);
        existingEvent.ifPresent(value -> {
            value.setName(event.getName());
            value.setLocation(event.getLocation());
            value.setDate(event.getDate());
            eventService.saveEvent(value);
        });
        return "redirect:/events/" + id;
    }

    @GetMapping("/{id}/delete")
    public String deleteEvent(@PathVariable Long id) {
        eventService.deleteEventById(id);
        return "redirect:/events";
    }

    @GetMapping("/{id}/join")
    public String joinEvent(@PathVariable Long id, Principal principal) {
        if (principal != null) {
            Optional<User> user = userService.findUserByEmail(principal.getName());
            Optional<Event> event = eventService.findEventById(id);
            if (user.isPresent() && event.isPresent()) {
                Event currentEvent = event.get();
                currentEvent.getAttendees().add(user.get());
                eventService.saveEvent(currentEvent);
            }
        }
        return "redirect:/events/" + id;
    }

    // Additional methods can go here
}