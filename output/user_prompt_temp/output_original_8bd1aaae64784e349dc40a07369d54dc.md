<|User Prompt|>
Create a prompt.
I want the AI to use this documentation format:

### **Database Description**
   - **Clear Overview**: Start with a concise overview of the database, highlighting its purpose and key components as per STEP 2.
   - **Assignment Alignment**: Explicitly state how each table and field aligns with the assignment's requirements.

### **Assumptions and Additions**
   - **Explicit Assumptions**: Document any assumptions made while designing the database, such as data types, field lengths, or optional fields.
   - **Justification for Additions**: Explain the rationale behind any additional fields or tables introduced that go beyond the assignment's specifications.

### **Reaction Policies**
   - **Policy Discussion**: Detail the reaction policies used in the database, like CASCADE on delete/update, and explain why they were chosen.

### **Table Descriptions and Data Types**
   - **Detailed Table Descriptions**: For each table, provide a detailed description including the purpose, fields, and data types.
   - **Data Type Rationale**: Explain the choice of data types for each field, aligning with the assignment's emphasis on appropriate data types.

### **Entity-Relationship (ER) Diagram**
   - **Comprehensive ER Diagram**: Include a detailed ER diagram, showcasing the relationships between tables and highlighting primary and foreign keys.
   - **Labeling and Legends**: Ensure the ER diagram is well-labeled and includes a legend for symbols used.

### **Stored Procedures Documentation**
   - **Insert Procedures**: Clearly document each stored procedure for inserting data into the tables, adhering to STEP 3.
   - **Query Procedures**: Document each query procedure, ensuring they are named as per the format specified in STEP 4.

I want them to use this strategy combined with the assignment guidelines (given in the next message). 
I will provide parts of the assignment code piece by piece.
Ensure every part of the assignment guidelines are assessed and then compare it against the documentation and the code. Then document it in detail. Do not just describe it. Ensure reasons are given for why things were chosen.
For parts of the document strategy that are not relevant for the current piece of code, leave as is and ignore. Update the documentation and return the new documentation. You will then use this for your next documentation, so that we are continuosly working on and changing the documentation until it is complete.


Optimise and clarify this prompt for use with AI's.

<|The Start of Assistant A's Answer|>
Create a prompt for the AI to analyze and document a given database assignment using the following documentation format:

### **Database Description**
   - **Clear Overview**: Provide a concise overview of the database, highlighting its purpose and key components.
   - **Assignment Alignment**: State how each table and field aligns with the assignment's requirements.

### **Assumptions and Additions**
   - **Explicit Assumptions**: Document any assumptions made while designing the database, such as data types, field lengths, or optional fields.
   - **Justification for Additions**: Explain the rationale behind any additional fields or tables introduced that go beyond the assignment's specifications.

### **Reaction Policies**
   - **Policy Discussion**: Detail the reaction policies used in the database, like CASCADE on delete/update, and explain why they were chosen.

### **Table Descriptions and Data Types**
   - **Detailed Table Descriptions**: For each table, provide a detailed description including the purpose, fields, and data types.
   - **Data Type Rationale**: Explain the choice of data types for each field, aligning with the assignment's emphasis on appropriate data types.

### **Entity-Relationship (ER) Diagram**
   - **Comprehensive ER Diagram**: Include a detailed ER diagram, showcasing the relationships between tables and highlighting primary and foreign keys.
   - **Labeling and Legends**: Ensure the ER diagram is well-labeled and includes a legend for symbols used.

### **Stored Procedures Documentation**
   - **Insert Procedures**: Clearly document each stored procedure for inserting data into the tables.
   - **Query Procedures**: Document each query procedure, ensuring they are named as per the specified format.

The AI will assess each part of the assignment guidelines, compare it against the documentation and the code, and document it in detail, providing reasons for why things were chosen. For parts of the document strategy that are not relevant for the current piece of code, they will be ignored. The AI will update the documentation and return the new documentation, which will be used for the next documentation, continuously working on and changing the documentation until it is complete.
<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
**Database Documentation Strategy**

### **Database Description**
- **Clear Overview**: Provide a concise summary of the database, highlighting its purpose and key components.
- **Assignment Alignment**: Explain how each table and field align with the assignment's requirements.

### **Assumptions and Additions**
- **Explicit Assumptions**: Document any assumptions made during database design, including data types, field lengths, or optional fields.
- **Justification for Additions**: Explain the rationale behind any additional fields or tables introduced.

### **Reaction Policies**
- **Policy Discussion**: Detail the reaction policies used in the database, such as CASCADE on delete/update, and explain why they were chosen.

### **Table Descriptions and Data Types**
- **Detailed Table Descriptions**: For each table, provide a detailed description including purpose, fields, and data types.
- **Data Type Rationale**: Explain the choice of data types for each field.

### **Entity-Relationship (ER) Diagram**
- **Comprehensive ER Diagram**: Include a detailed ER diagram showcasing table relationships and highlighting primary and foreign keys.
- **Labeling and Legends**: Ensure the ER diagram is well-labeled and includes a legend for symbols used.

### **Stored Procedures Documentation**
- **Insert Procedures**: Clearly document each stored procedure for inserting data into tables.
- **Query Procedures**: Document each query procedure.

**Guidelines for Continuous Documentation**

1. **Assess Each Part of the Assignment**: Evaluate the provided code piece against the assignment guidelines.
2. **Compare Against Documentation and Code**: Compare the documentation with the code to ensure accuracy.
3. **Document Reasons for Choices**: Provide detailed explanations for design decisions and choices made.

**Continuous Documentation Process**

- Update the documentation after each code piece is provided.
- Ensure all relevant sections are addressed.
- Ignore sections not applicable to the current code piece.

This strategy will be used to create and refine the database documentation until it is complete.
<|The End of Assistant B's Answer|>