# TextField

Enhanced text input component with validation, styling, and accessibility features.

## Overview

The `TextField` component extends SwiftUI's native TextField with additional styling options, validation support, helper text, and improved accessibility. It provides a consistent text input experience across your application with built-in support for different field types and states.

## Basic Usage

### Simple Text Field

```swift
@State private var name = ""

TextField("Enter your name", text: $name)
    .textFieldStyle(.default)
```

### Text Field with Helper Text

```swift
@State private var email = ""
@State private var emailHelper = ""
@State private var helperStyle = FieldHelperStyle.none

TextField("Email Address", text: $email)
    .textFieldStyle(.default)
    .keyboardType(.emailAddress)
    .autocapitalization(.none)
    .fieldHelper(emailHelper, style: $helperStyle)
    .onChange(of: email) { newValue in
        validateEmail(newValue)
    }

private func validateEmail(_ email: String) {
    if email.isEmpty {
        emailHelper = ""
        helperStyle = .none
    } else if isValidEmail(email) {
        emailHelper = "Email looks good!"
        helperStyle = .success
    } else {
        emailHelper = "Please enter a valid email address"
        helperStyle = .error
    }
}
```

## Text Field Styles

### Default Style

The standard text field appearance:

```swift
TextField("Placeholder", text: $text)
    .textFieldStyle(.default)
```

### Labeled Style

Text field with floating label:

```swift
TextField("Full Name", text: $fullName)
    .textFieldStyle(.labeled)
```

## Validation and Helper Text

### Helper Text Styles

Show different types of helper messages:

```swift
// Informational helper
TextField("Username", text: $username)
    .textFieldStyle(.default)
    .fieldHelper("Must be 3-20 characters", style: .constant(.info))

// Success state
TextField("Password", text: $password)
    .textFieldStyle(.default)
    .fieldHelper("Strong password!", style: .constant(.success))

// Warning state
TextField("Confirm Password", text: $confirmPassword)
    .textFieldStyle(.default)
    .fieldHelper("Passwords don't match", style: .constant(.warning))

// Error state
TextField("Email", text: $email)
    .textFieldStyle(.default)
    .fieldHelper("Invalid email format", style: .constant(.error))
```

### Field Title

Add titles to your text fields:

```swift
TextField("Enter email", text: $email)
    .textFieldStyle(.default)
    .fieldTitle("Email Address")
```

## Specialized Text Fields

### Secure Text Field

For password input:

```swift
@State private var password = ""
@State private var isPasswordVisible = false

if isPasswordVisible {
    TextField("Password", text: $password)
        .textFieldStyle(.default)
} else {
    SecureField("Password", text: $password)
        .textFieldStyle(.default)
}
```

### Multi-line Text Field

For longer text input:

```swift
@State private var notes = ""

TextEditor(text: $notes)
    .textFieldStyle(.default)
    .frame(minHeight: 100)
    .fieldHelper("Add any additional notes", style: .constant(.info))
```

### Numeric Fields

For number input:

```swift
@State private var age = ""

TextField("Age", text: $age)
    .textFieldStyle(.default)
    .keyboardType(.numberPad)
    .onChange(of: age) { newValue in
        // Filter non-numeric characters
        age = newValue.filter { $0.isNumber }
    }
```

## Advanced Examples

### Registration Form

```swift
struct RegistrationForm: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var emailHelper = ""
    @State private var emailHelperStyle = FieldHelperStyle.none
    @State private var passwordHelper = ""
    @State private var passwordHelperStyle = FieldHelperStyle.none
    
    var body: some View {
        VStack(spacing: .large) {
            // Personal Information
            SectionView("Personal Information") {
                VStack(spacing: .medium) {
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(.default)
                        .fieldTitle("First Name")
                    
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(.default)
                        .fieldTitle("Last Name")
                }
            }
            
            // Account Details
            SectionView("Account Details") {
                VStack(spacing: .medium) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.default)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .fieldTitle("Email Address")
                        .fieldHelper(emailHelper, style: $emailHelperStyle)
                        .onChange(of: email) { validateEmail($0) }
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.default)
                        .fieldTitle("Password")
                        .fieldHelper(passwordHelper, style: $passwordHelperStyle)
                        .onChange(of: password) { validatePassword($0) }
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(.default)
                        .fieldTitle("Confirm Password")
                        .fieldHelper(passwordsMatch ? "" : "Passwords don't match", 
                                   style: .constant(passwordsMatch ? .none : .error))
                }
            }
            
            // Submit Button
            Button("Create Account") {
                createAccount()
            }
            .buttonStyle(.primary)
            .controlSize(.large)
            .disabled(!isFormValid)
        }
        .padding()
    }
    
    private var passwordsMatch: Bool {
        password == confirmPassword && !confirmPassword.isEmpty
    }
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && 
        isValidEmail(email) && isValidPassword(password) && passwordsMatch
    }
    
    private func validateEmail(_ email: String) {
        if email.isEmpty {
            emailHelper = ""
            emailHelperStyle = .none
        } else if isValidEmail(email) {
            emailHelper = "Email looks good!"
            emailHelperStyle = .success
        } else {
            emailHelper = "Please enter a valid email address"
            emailHelperStyle = .error
        }
    }
    
    private func validatePassword(_ password: String) {
        if password.isEmpty {
            passwordHelper = ""
            passwordHelperStyle = .none
        } else if password.count < 8 {
            passwordHelper = "Password must be at least 8 characters"
            passwordHelperStyle = .error
        } else if isStrongPassword(password) {
            passwordHelper = "Strong password!"
            passwordHelperStyle = .success
        } else {
            passwordHelper = "Include uppercase, lowercase, and numbers"
            passwordHelperStyle = .warning
        }
    }
}
```

### Search Field

```swift
struct SearchField: View {
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .textFieldStyle(.default)
                .onSubmit {
                    performSearch()
                }
            
            if !searchText.isEmpty {
                Button {
                    clearSearch()
                } label: {
                    Icon(.xmark)
                }
                .buttonStyle(.quaternary)
                .accessibilityLabel("Clear search")
            }
        }
        .overlay(alignment: .trailing) {
            if isSearching {
                ProgressView()
                    .controlSize(.small)
                    .padding(.trailing)
            }
        }
    }
    
    private func performSearch() {
        isSearching = true
        // Perform search
        isSearching = false
    }
    
    private func clearSearch() {
        searchText = ""
    }
}
```

### Form Validation

```swift
struct ContactForm: View {
    @State private var formData = ContactFormData()
    @State private var validationErrors: [String: String] = [:]
    
    var body: some View {
        Form {
            Section("Contact Information") {
                TextField("Full Name", text: $formData.fullName)
                    .textFieldStyle(.default)
                    .fieldHelper(validationErrors["fullName"] ?? "", 
                               style: .constant(validationErrors["fullName"] != nil ? .error : .none))
                
                TextField("Email", text: $formData.email)
                    .textFieldStyle(.default)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .fieldHelper(validationErrors["email"] ?? "", 
                               style: .constant(validationErrors["email"] != nil ? .error : .none))
                
                TextField("Phone", text: $formData.phone)
                    .textFieldStyle(.default)
                    .keyboardType(.phonePad)
                    .fieldHelper(validationErrors["phone"] ?? "", 
                               style: .constant(validationErrors["phone"] != nil ? .error : .none))
            }
            
            Section("Message") {
                TextEditor(text: $formData.message)
                    .frame(minHeight: 100)
                    .fieldHelper(validationErrors["message"] ?? "", 
                               style: .constant(validationErrors["message"] != nil ? .error : .none))
            }
        }
        .onSubmit {
            validateForm()
        }
    }
    
    private func validateForm() {
        validationErrors.removeAll()
        
        if formData.fullName.isEmpty {
            validationErrors["fullName"] = "Name is required"
        }
        
        if !isValidEmail(formData.email) {
            validationErrors["email"] = "Valid email is required"
        }
        
        if formData.message.isEmpty {
            validationErrors["message"] = "Message is required"
        }
    }
}
```

## Accessibility

### Automatic Features

OversizeUI text fields automatically provide:

- **VoiceOver Support**: Proper labeling and state announcements
- **Dynamic Type**: Automatic text scaling with system font sizes
- **Focus Management**: Proper keyboard navigation support
- **Error Announcements**: Helper text is announced to screen readers

### Custom Accessibility

Enhance accessibility for complex forms:

```swift
TextField("Credit Card Number", text: $cardNumber)
    .textFieldStyle(.default)
    .keyboardType(.numberPad)
    .accessibilityLabel("Credit card number")
    .accessibilityHint("Enter your 16-digit credit card number")
    .textContentType(.creditCardNumber)
```

## Design Guidelines

### Do's

- ✅ Use clear, descriptive placeholder text
- ✅ Provide helpful validation messages
- ✅ Group related fields logically
- ✅ Use appropriate keyboard types
- ✅ Show field requirements upfront
- ✅ Provide real-time validation feedback

### Don'ts

- ❌ Don't use placeholder text as labels
- ❌ Don't show error messages before user interaction
- ❌ Don't make required fields unclear
- ❌ Don't use generic error messages
- ❌ Don't forget to handle empty states

## API Reference

### Text Field Styles

```swift
extension TextFieldStyle {
    static var `default`: LabeledTextFieldStyle
    static var labeled: LabeledTextFieldStyle
}
```

### Modifiers

```swift
// Helper text and validation
func fieldHelper(_ text: String, style: Binding<FieldHelperStyle>) -> some View
func fieldTitle(_ title: String) -> some View

// Validation
func fieldValidation(_ validation: @escaping (String) -> ValidationResult) -> some View
```

### Types

```swift
enum FieldHelperStyle {
    case none
    case info
    case success
    case warning
    case error
}

struct ValidationResult {
    let isValid: Bool
    let message: String?
    let style: FieldHelperStyle
}
```

## See Also

- ``Button``
- ``Select``
- ``SectionView``
- <doc:DesignSystem/Typography>
- <doc:Accessibility>