**System Instruction: Entity Categorization and Context Requirement**

### Description

This system performs two tasks:

1. **Categorize a sentence into entity types**: 
   - Text
   - Image
   - Shape
   - Slide
   - Presentation

2. **Determine if a sentence requires context**:
   - Context is needed when additional information about the content of a presentation is required to fulfill the task described in the sentence.

### Examples

#### Example 1: Changing Text Color

- **User Input**: Make the title text on this slide red.
- **Assistant Response**:
  - **Categories**: text
  - **Thoughts**: We can select the title text and make it red without knowing the existing text properties. Therefore, we do not need context.
  - **RequiresContext**: false

#### Example 2: Adding a Poem

- **User Input**: Add text that’s a poem about the life of a high school student with emojis.
- **Assistant Response**:
  - **Categories**: text
  - **Thoughts**: We need to know whether there is existing text on the slide to add the new poem. Therefore, we need context.
  - **RequiresContext**: true

### Implementation

```ruby
# Define the entity categories
ENTITY_TYPES = %w[text image shape slide presentation]

# Define the context requirements
def requires_context?(task)
  # Tasks requiring context include adding new text
  task.downcase.include?("add text") || task.downcase.include?("new text")
end

# Function to categorize a sentence
def categorize_sentence(sentence)
  # Initialize categories
  categories = []

  # Check each entity type
  ENTITY_TYPES.each do |entity|
    # If the sentence includes the entity type, add it to the categories
    if sentence.downcase.include?(entity)
      categories << entity
    end
  end

  categories
end

# Function to determine if a sentence requires context
def determine_requires_context(sentence)
  requires_context?(sentence)
end

# Example usage
user_input1 = "Make the title text on this slide red."
assistant_response1 = {
  categories: categorize_sentence(user_input1),
  thoughts: "We can select the title text and make it red without knowing the existing text properties. Therefore, we do not need context.",
  requires_context: determine_requires_context(user_input1)
}

user_input2 = "Add text that’s a poem about the life of a high school student with emojis."
assistant_response2 = {
  categories: categorize_sentence(user_input2),
  thoughts: "We need to know whether there is existing text on the slide to add the new poem. Therefore, we need context.",
  requires_context: determine_requires_context(user_input2)
}

puts "Example 1:"
puts "User Input: #{user_input1}"
puts "Assistant Response:"
puts "Categories: #{assistant_response1[:categories].join(", ")}"
puts "Thoughts: #{assistant_response1[:thoughts]}"
puts "Requires Context: #{assistant_response1[:requires_context]}"

puts "\nExample 2:"
puts "User Input: #{user_input2}"
puts "Assistant Response:"
puts "Categories: #{assistant_response2[:categories].join(", ")}"
puts "Thoughts: #{assistant_response2[:thoughts]}"
puts "Requires Context: #{assistant_response2[:requires_context]}"
```

### Explanation

This Ruby implementation includes:

- **Entity Types**: Defines the categories of entities in a PowerPoint presentation.
- **Requires Context**: Determines if a sentence requires context based on the task description.
- **Categorize Sentence**: Categorizes a given sentence into entity types.
- **Determine Requires Context**: Checks if a sentence requires context.

The example usage demonstrates how to use these functions to generate assistant responses for two different user inputs.