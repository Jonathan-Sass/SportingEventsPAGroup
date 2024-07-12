package com.jsass.sportingeventspagroup.controllers;

import com.jsass.sportingeventspagroup.models.Event;
import com.jsass.sportingeventspagroup.services.EventService;
import com.jsass.sportingeventspagroup.models.Message;
import com.jsass.sportingeventspagroup.models.User;
import com.jsass.sportingeventspagroup.services.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import java.util.Optional;

@Controller
@RequestMapping("/events")
public class EventController {
    @Autowired
    private EventService eventService;

    @Autowired
    private MessageService messageService;

    @GetMapping
    public String listEvents(Model model) {
        model.addAttribute("events", eventService.findAllEvents());
        return "search";
    }

    @GetMapping("/{id}")
    public String viewEvent(@PathVariable Long id, Model model) {
        Optional<Event> event = eventService.findEventById(id);
        if (event.isPresent()) {
            model.addAttribute("event", event.get());
            model.addAttribute("message", new Message());
            model.addAttribute("messageList", event.get().getMessages()); // Include messages
        }
        return "viewEvent";
    }

    @GetMapping("/new")
    public String showEventForm(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/users/login";
        }
        model.addAttribute("event", new Event());
        return "createEvent";
    }

    @PostMapping("/create")
    public String createEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/users/login";
        }
        if (result.hasErrors()) {
            return "createEvent";
        }
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        event.setCreator(loggedInUser);
        eventService.saveEvent(event);
        return "redirect:/events";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/users/login";
        }
        Optional<Event> event = eventService.findEventById(id);
        event.ifPresent(value -> model.addAttribute("event", value));
        return "editEvent";
    }

    @PostMapping("/{id}/update")
    public String updateEvent(@PathVariable Long id, @Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/users/login";
        }
        if (result.hasErrors()) {
            return "editEvent";
        }
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
    public String deleteEvent(@PathVariable Long id, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
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
        event.ifPresent(e -> {
            if (!e.getAttendees().contains(loggedInUser)) {
                e.getAttendees().add(loggedInUser);
                eventService.saveEvent(e);
            }
        });
        return "redirect:/events/" + id;
    }

    @GetMapping("/{id}/leave")
    public String leaveEvent(@PathVariable Long id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }
        Optional<Event> event = eventService.findEventById(id);
        event.ifPresent(e -> {
            e.getAttendees().remove(loggedInUser);
            eventService.saveEvent(e);
        });
        return "redirect:/events/" + id;
    }
}
