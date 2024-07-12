package com.jsass.sportingeventspagroup.controllers;

import com.jsass.sportingeventspagroup.models.Message;
import com.jsass.sportingeventspagroup.models.Event;
import com.jsass.sportingeventspagroup.models.User;
import com.jsass.sportingeventspagroup.services.MessageService;
import com.jsass.sportingeventspagroup.services.EventService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping("/messages")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private EventService eventService;

    @PostMapping("/create")
    public String createMessage(@RequestParam Long eventId, @ModelAttribute("message") Message message, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }

        Optional<Event> event = eventService.findEventById(eventId);
        if (event.isPresent()) {
            message.setEvent(event.get());
            message.setAuthor(loggedInUser.getFirstName() + " " + loggedInUser.getLastName());
            messageService.saveMessage(message);
        }

        return "redirect:/events/" + eventId;
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }

        Optional<Message> message = messageService.findMessageById(id);
        if (message.isPresent()) {
            model.addAttribute("message", message.get());
            return "editMessage";
        }

        return "redirect:/users/dashboard";
    }

    @PostMapping("/{id}/update")
    public String updateMessage(@PathVariable Long id, @ModelAttribute("message") Message message, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }

        Optional<Message> existingMessage = messageService.findMessageById(id);
        if (existingMessage.isPresent()) {
            Message updatedMessage = existingMessage.get();
            updatedMessage.setContent(message.getContent());
            messageService.saveMessage(updatedMessage);
            return "redirect:/events/" + updatedMessage.getEvent().getId();
        }

        return "redirect:/users/dashboard";
    }

    @GetMapping("/{id}/delete")
    public String deleteMessage(@PathVariable Long id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }

        Optional<Message> message = messageService.findMessageById(id);
        if (message.isPresent()) {
            Long eventId = message.get().getEvent().getId();
            messageService.deleteMessageById(id);
            return "redirect:/events/" + eventId;
        }

        return "redirect:/users/dashboard";
    }
}
