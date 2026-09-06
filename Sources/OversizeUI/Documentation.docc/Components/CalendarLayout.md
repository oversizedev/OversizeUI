# CalendarLayout

A scrollable month calendar above sectioned content.

## Overview

``CalendarLayout`` renders a month grid over a date interval and lets you supply the view for each
day. Content below the calendar is built from native `Section`s, exactly as in ``Layout``.

> Availability: iOS 18 only.

## Basic Usage

```swift
@State private var selection: Date = .init()

private var interval: DateInterval {
    let calendar = Calendar.current
    let start = calendar.date(byAdding: .month, value: -6, to: .init()) ?? .init()
    let end = calendar.date(byAdding: .month, value: 6, to: .init()) ?? .init()
    return DateInterval(start: start, end: end)
}

NavigationStack {
    CalendarLayout(interval: interval, selection: $selection) {
        Section("Events") {
            Row(selection.formatted(date: .abbreviated, time: .omitted))
        }
    } day: { date in
        DefaultCalendarDayView(date: date, selection: $selection)
    }
}
```

## Custom Day View

``DefaultCalendarDayView`` handles selection and today highlighting, but any view works — this is
where you add event indicators:

```swift
CalendarLayout(interval: interval, selection: $selection) {
    Section("Events") { ... }
} day: { date in
    VStack(spacing: .xxxSmall) {
        DefaultCalendarDayView(date: date, selection: $selection)

        if hasEvents(on: date) {
            Circle()
                .fill(Color.accent)
                .frame(width: 4, height: 4)
        }
    }
}
```

## Topics

### Related layouts

- ``Layout``

### Day views

- ``DefaultCalendarDayView``
