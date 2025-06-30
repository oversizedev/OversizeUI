# Avatar

Display user profile pictures with automatic fallback to initials.

## Overview

The `Avatar` component is used to represent users in your interface. It can display profile images, and automatically falls back to displaying the user's initials when no image is available. The component supports various sizes, custom styling, and accessibility features.

### When to Use Avatar

- **User Profiles**: Display user avatars in profile screens
- **Contact Lists**: Show contact photos in lists and grids
- **Team Members**: Display team member photos in organizational interfaces
- **Comments & Reviews**: Show user avatars next to user-generated content
- **Navigation**: Display current user avatar in navigation bars

## Basic Usage

### Simple Avatar with Initials

```swift
Avatar(firstName: "John", lastName: "Doe")
    .controlSize(.medium)
```

### Avatar with Custom Image

```swift
Avatar(avatar: Image("profile-photo"))
    .controlSize(.large)
```

### Avatar with Icon

```swift
Avatar(icon: Image(systemName: "person.fill"))
    .controlSize(.small)
```

## Customization

### Control Sizes

Avatars support various sizes through the `controlSize` environment value:

```swift
// Small avatar (32x32 points)
Avatar(firstName: "AI", lastName: "Bot")
    .controlSize(.small)

// Medium avatar (48x48 points) - Default
Avatar(firstName: "John", lastName: "Doe")
    .controlSize(.medium)

// Large avatar (64x64 points)
Avatar(firstName: "Jane", lastName: "Smith")
    .controlSize(.large)

// Extra large avatar (80x80 points)
Avatar(firstName: "Alex", lastName: "Johnson")
    .controlSize(.extraLarge)
```

### Custom Styling

#### Stroke Border

Add a stroke border around the avatar:

```swift
Avatar(firstName: "John", lastName: "Doe")
    .stroke(.accent, lineWidth: 2)
```

#### Custom Background

Set a custom background color or gradient:

```swift
// Solid color background
Avatar(firstName: "AI", lastName: "Bot")
    .avatarBackground(.color(.blue))

// Gradient background
Avatar(firstName: "Jane", lastName: "Smith")
    .avatarBackground(.gradient([.purple, .pink]))
```

#### Text and Image Color

Customize the text and image colors:

```swift
Avatar(firstName: "John", lastName: "Doe")
    .avatarTextColor(.white)
    .avatarBackground(.color(.black))
```

## Advanced Examples

### Team Member Grid

```swift
struct TeamMemberGrid: View {
    let teamMembers = [
        ("John", "Doe", "john-doe"),
        ("Jane", "Smith", "jane-smith"),
        ("Alex", "Johnson", nil),
        ("Sam", "Wilson", "sam-wilson")
    ]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
            ForEach(teamMembers, id: \.0) { member in
                VStack {
                    if let imageName = member.2 {
                        Avatar(avatar: Image(imageName))
                    } else {
                        Avatar(firstName: member.0, lastName: member.1)
                    }
                    
                    Text("\(member.0) \(member.1)")
                        .caption(.medium)
                        .multilineTextAlignment(.center)
                }
                .controlSize(.large)
            }
        }
        .padding()
    }
}
```

### Profile Header

```swift
struct ProfileHeader: View {
    let user: User
    @State private var isEditingPhoto = false
    
    var body: some View {
        VStack(spacing: .medium) {
            Avatar(
                firstName: user.firstName,
                lastName: user.lastName,
                avatar: user.profileImage
            )
            .controlSize(.extraLarge)
            .stroke(.accent, lineWidth: 3)
            .onTapGesture {
                isEditingPhoto = true
            }
            .accessibilityLabel("Profile photo")
            .accessibilityHint("Double-tap to change profile photo")
            
            VStack(spacing: .xSmall) {
                Text(user.fullName)
                    .title2(.bold)
                
                Text(user.email)
                    .body(.medium)
                    .foregroundColor(.onSurfaceSecondary)
            }
        }
        .sheet(isPresented: $isEditingPhoto) {
            PhotoPicker { newImage in
                user.profileImage = newImage
            }
        }
    }
}
```

### Contact List Row

```swift
struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        Row {
            HStack(spacing: .medium) {
                Avatar(
                    firstName: contact.firstName,
                    lastName: contact.lastName,
                    avatar: contact.photo
                )
                .controlSize(.medium)
                
                VStack(alignment: .leading, spacing: .xxSmall) {
                    Text(contact.fullName)
                        .headline()
                    
                    Text(contact.phoneNumber)
                        .body(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                }
                
                Spacer()
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(contact.fullName), \(contact.phoneNumber)")
    }
}
```

## Accessibility

The Avatar component is designed with accessibility in mind:

### Automatic Labels

Avatars automatically provide meaningful accessibility labels:

```swift
// Automatically provides "John Doe" as accessibility label
Avatar(firstName: "John", lastName: "Doe")

// For image avatars, provide custom label
Avatar(avatar: Image("user-photo"))
    .accessibilityLabel("User profile photo")
```

### VoiceOver Support

- Initials are read as individual letters when appropriate
- Profile images should include descriptive labels
- Interactive avatars include appropriate hints

### Dynamic Type

Avatars automatically scale with Dynamic Type settings to ensure legibility for users with different font size preferences.

## Design Guidelines

### Do's

- ✅ Use consistent avatar sizes within the same context
- ✅ Provide fallback initials for all users
- ✅ Use appropriate contrast for initials on background colors
- ✅ Include meaningful accessibility labels for profile images
- ✅ Consider using stroke borders to improve visual hierarchy

### Don'ts

- ❌ Don't use avatars for non-user entities (use icons instead)
- ❌ Don't make avatars too small to be recognizable
- ❌ Don't use low-contrast color combinations
- ❌ Don't rely solely on color to convey information
- ❌ Don't forget to handle loading states for remote images

## API Reference

### Initializers

```swift
// Avatar with initials
init(firstName: String?, lastName: String?)

// Avatar with custom image
init(avatar: Image)

// Avatar with system icon
init(icon: Image)

// Full customization
init(
    firstName: String? = nil,
    lastName: String? = nil,
    avatar: Image? = nil,
    icon: Image? = nil
)
```

### Modifiers

```swift
// Styling
func stroke(_ color: Color, lineWidth: CGFloat) -> Avatar
func avatarBackground(_ background: AvatarBackgroundType) -> Avatar
func avatarTextColor(_ color: Color) -> Avatar

// Control Size (Environment)
func controlSize(_ size: ControlSize) -> some View
```

### Types

```swift
enum AvatarBackgroundType {
    case color(Color)
    case gradient([Color])
}
```

## See Also

- ``Button``
- ``Row``
- ``SectionView``
- <doc:DesignSystem/Colors>
- <doc:Accessibility>