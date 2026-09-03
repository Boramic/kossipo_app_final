import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/notification_strip.dart';
import '../widgets/family_events_preview.dart';

final demoPromos = [
  {
    "image":
    "https://images.unsplash.com/photo-1517457373958-b7bdd4587205",
    "title": "Discover Family Roots",
    "subtitle": "Reconnect with your heritage",
  },
  {
    "image":
    "https://images.unsplash.com/photo-1529156069898-49953e39b3ac",
    "title": "Save Precious Memories",
    "subtitle": "Keep every generation alive",
  },
];

final demoMemories = [
  {
    "image":
    "https://images.unsplash.com/photo-1509099836639-18ba1795216d",
    "title": "Grandfather Wedding",
    "author": "Borel Family",
    "date": "1962",
    "count": 12,
  },
  {
    "image":
    "https://images.unsplash.com/photo-1511895426328-dc8714191300",
    "title": "Village Celebration",
    "author": "Waffo Family",
    "date": "1987",
    "count": 8,
  },
];

final demoTimeline = [
  {
    "year": "1945",
    "title": "Family Migration",
    "description":
    "The family moved to the western region.",
  },
  {
    "year": "1972",
    "title": "First Reunion",
    "description":
    "The first official family gathering.",
  },
];

final demoStories = [
  {
    "author": "Grandma Alice",
    "text":
    "Our roots began near the riverbanks where traditions shaped our family identity.",
  },
  {
    "author": "Jean Pierre",
    "text":
    "We have always celebrated unity and passed our stories through generations.",
  },
];

/// NOTIFICATIONS (emoji style)
final demoNotifications = [
  NotificationStatusData(
    emoji: "😣",
    color: const Color(0xFFE53935),
    count: 3,
    isUrgent: true,
  ),
  NotificationStatusData(
    emoji: "😐",
    color: const Color(0xFFFF9800),
    count: 5,
  ),
  NotificationStatusData(
    emoji: "😊",
    color: const Color(0xFF00A86B),
    count: 2,
  ),
  NotificationStatusData(
    emoji: "😁",
    color: Colors.blue,
    count: 1,
  ),
];

final demoEventsPreview = [
  const FamilyEventModel(
    title: "Ngondo Festival",
    image: "assets/images/family name.jpg",
    date: "12 Aug 2026",
  ),
  const FamilyEventModel(
    title: "Family Reunion",
    image: "assets/images/family_tree_preview.jpg",
    date: "25 Sep 2026",
  ),
];

final demoEvents = [
  CulturalEvent(
    id: "1",
    title: "Ngondo Festival",
    imageUrl:
    "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
    location: "Douala",
  ),
  CulturalEvent(
    id: "2",
    title: "Ngouon Ceremony",
    imageUrl:
    "https://images.unsplash.com/photo-1516302752625-fcc3c50ae61f",
    location: "Foumban",
  ),
  CulturalEvent(
    id: "3",
    title: "Bamoun Heritage",
    imageUrl:
    "https://images.unsplash.com/photo-1492684223066-81342ee5ff30",
    location: "West Cameroon",
  ),
];