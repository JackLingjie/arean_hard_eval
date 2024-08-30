<|User Prompt|>
convert this system prompt into a langchain few shot template that will be with the ruby implementation of langchain:
```
System Instruction: There are 5 categories of entities in a PowerPoint presentation: text, image, shape, slide, presentation. You need to perform the following tasks: 1. Categorize a given sentence into entity categories. Each sentence can have more than one category. 2. Classify whether a sentence requires context. Context is required when additional information about the content of a presentation is required to fulfill the task described in the sentence. - Adding an image about a given topic does not require context. - Adding new text needs context to decide where to place the text on the current slide. ... Let’s think step by step. Here are some examples: User: Make the title text on this slide red Assistant: Categories: text Thoughts: We can select the title text and make it red without knowing the existing text properties. Therefore we do not need context. RequiresContext: false User: Add text that’s a poem about the life of a high school student with emojis. Assistant: Categories: text Thoughts: We need to know whether there is existing text on the slide to add the new poem. Therefore we need context. RequiresContext: true ...```

<|The Start of Assistant A's Answer|>
```ruby
# Langchain Few-shot Template with Ruby Implementation

# Categories: text, image, shape, slide, presentation
# Task 1: Categorize a given sentence into entity categories (can have more than one category)
# Task 2: Classify whether a sentence requires context (true/false)

def categorize_and_check_context(sentence)
  categories = []
  requires_context = false

  # Categorization
  categories << "text" if sentence.match?(/text|title|poem/)
  categories << "image" if sentence.match?(/image/)
  categories << "shape" if sentence.match?(/shape/)
  categories << "slide" if sentence.match?(/slide/)
  categories << "presentation" if sentence.match?(/presentation/)

  # Context requirement
  case sentence
  when /title text|image about a given topic/
    requires_context = false
  when /Add text|poem|emojis/
    requires_context = true
  end

  { categories: categories, requires_context: requires_context }
end

# Example 1
sentence1 = "Make the title text on this slide red"
result1 = categorize_and_check_context(sentence1)
puts "Example 1: #{result1}"

# Example 2
sentence2 = "Add text that’s a poem about the life of a high school student with emojis"
result2 = categorize_and_check_context(sentence2)
puts "Example 2: #{result2}"
```

<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
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
<|The End of Assistant B's Answer|>