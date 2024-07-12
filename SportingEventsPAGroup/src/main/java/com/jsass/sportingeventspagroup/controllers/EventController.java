package com.jsass.sportingeventspagroup.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.jsass.sportingeventspagroup.models.Event;
import com.jsass.sportingeventspagroup.models.User;
import com.jsass.sportingeventspagroup.services.EventService;

import jakarta.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@RequestMapping("/events")
public class EventController {
    @Autowired
    private EventService eventService;

    @GetMapping
    public String listEvents(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }
        model.addAttribute("events", eventService.findAllEvents());
        return "search";
    }

    @GetMapping("/{id}")
    public String viewEvent(@PathVariable Long id, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }
        Optional<Event> event = eventService.findEventById(id);
        event.ifPresent(value -> model.addAttribute("event", value));
        return "viewEvent";
    }

    @GetMapping("/new")
    public String showEventForm(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }
        model.addAttribute("event", new Event());
        return "createEvent";
    }

    @PostMapping("/create")
    public String createEvent(@ModelAttribute("event") Event event, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            event.setCreator(loggedInUser);
            eventService.saveEvent(event);
            return "redirect:/users/dashboard"; // Redirect to user's dashboard
        }
        return "redirect:/users/login";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }
        Optional<Event> event = eventService.findEventById(id);
        event.ifPresent(value -> model.addAttribute("event", value));
        return "editEvent";
    }

    @PostMapping("/{id}/update")
    public String updateEvent(@PathVariable Long id, @ModelAttribute("event") Event event, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            Optional<Event> existingEvent = eventService.findEventById(id);
            existingEvent.ifPresent(value -> {
                value.setName(event.getName());
                value.setLocation(event.getLocation());
                value.setDate(event.getDate());
                eventService.saveEvent(value);
            });
        }
        return "redirect:/events/" + id;
    }

    @GetMapping("/{id}/delete")
    public String deleteEvent(@PathVariable Long id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }
        eventService.deleteEventById(id);
        return "redirect:/events";
    }

    @GetMapping("/{id}/join")
    public String joinEvent(@PathVariable Long id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }
        Optional<Event> event = eventService.findEventById(id);
        if (loggedInUser != null && event.isPresent()) {
            Event currentEvent = event.get();
            currentEvent.getAttendees().add(loggedInUser);
            eventService.saveEvent(currentEvent);
        }
        return "redirect:/events/" + id;
    }

    // Additional methods can go here
}
