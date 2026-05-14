---
name: conducting-research
description: Guides systematic research methodology covering the complete workflow from defining scope through source evaluation, information synthesis, and determining completion. Provides frameworks for assessing source authority, recency, accuracy, bias, and relevance. Supports both breadth-first and depth-first approaches. Use when users ask to research, investigate, explore, look into topics, compare options, learn about unfamiliar domains, find information, or understand current state. Essential for researcher-agent during Research phase, source evaluation, synthesis activities, applying research methodology, and determining completion criteria for research tasks.
---

# Conducting Research

## Purpose

Enable systematic, thorough research that produces reliable insights while avoiding common pitfalls like superficial understanding, poor source selection, or getting lost in irrelevant details.

## When to Use

Use this Skill when:
- User asks to "research", "investigate", "explore", "understand deeply", "look into", "compare", "learn about", or "find out" something
- User needs to choose between multiple options or alternatives
- Claude needs to build knowledge about an unfamiliar topic, system, or domain
- User wants to evaluate or compare multiple options
- Claude needs to find authoritative information about current technologies, methods, or concepts
- User asks questions that require synthesis from multiple sources
- Claude is uncertain about something and needs to validate assumptions
- The task requires going beyond training knowledge to find current or specialized information

## Required Inputs

Before starting research, clarify:

1. **Research question**: What specifically needs to be understood?
2. **Scope**: How broad or narrow should the investigation be?
3. **Purpose**: How will this research be used? (Informs depth and format)
4. **Constraints**: Time limits, preferred sources, depth requirements
5. **Success criteria**: What would make the research "complete enough"?

If any of these are unclear, ask the user before proceeding.

## Outputs Produced

Research typically produces one or more of the following deliverables:

1. **Research summary**: Concise answer to the research question with key findings and takeaways
2. **Detailed findings report**: Comprehensive analysis organized by theme or sub-question, with evidence and source citations
3. **Comparison table or matrix**: For evaluative research comparing multiple options across key dimensions
4. **Recommendation with rationale**: When research informs a decision, includes pros/cons and reasoning
5. **Annotated source list**: Bibliography of consulted sources with quality ratings and summaries
6. **Research notes**: Structured notes documenting the investigation process, organized by sub-topic

Adapt output format to user needs and stated purpose. For quick investigations, a summary may suffice. For complex decisions, provide detailed findings with comprehensive analysis.

## Research Workflow

### Phase 1: Define and Frame

**Goal**: Create a clear research plan

**Checkpoint**: Research plan documented with clear question, scope, and success criteria

1. **Articulate the core question**
   - Write it explicitly as a question or statement
   - Break complex questions into sub-questions
   - Identify assumptions that need validation

2. **Set boundaries**
   - Define what's in scope vs out of scope
   - Establish time constraints
   - Determine required depth level (overview vs deep dive)

3. **Identify success criteria**
   - What specific knowledge gaps need to be filled?
   - What decisions or actions will this research enable?
   - How will you know when you have enough information?

**Example:**
```
Research question: Should we use PostgreSQL or MongoDB?

Sub-questions:
- What are the key differences in data models?
- What are performance characteristics for our use case?
- What are operational complexity differences?
- What does the ecosystem look like for each?

Scope: Focus on web application use cases, not data warehouse/analytics
Success criteria: Clear recommendation with 3-5 key decision factors
```

### Phase 2: Source Identification and Evaluation

**Goal**: Find reliable, relevant information sources

**Checkpoint**: At least 3 high-quality sources identified and evaluated for authority, recency, accuracy, bias, and relevance

#### Finding Sources

Start with high-quality sources and expand as needed:

1. **Primary sources** (highest reliability):
   - Official documentation
   - Research papers and academic publications
   - Primary data sources
   - Official project repositories and changelogs

2. **Secondary sources** (good for context):
   - Established technical books and guides
   - Well-maintained tutorial sites
   - Expert blog posts (verify expertise)
   - Reputable news and analysis sites

3. **Community sources** (useful but verify):
   - Stack Overflow (for specific problems)
   - Reddit/HN discussions (for opinions and experiences)
   - GitHub issues and discussions
   - Conference talks and presentations

#### Evaluating Source Quality

For each source, ask:

**Authority**:
- Who wrote this? What are their credentials?
- Is this an official source or third-party?
- Is the author/organization recognized in the field?

**Recency**:
- When was this published/updated?
- Is this information still current?
- For fast-moving fields, prioritize recent sources

**Accuracy**:
- Does this cite other reliable sources?
- Can you verify key claims elsewhere?
- Are there obvious errors or inconsistencies?

**Bias**:
- Does the author have conflicts of interest?
- Is this promotional material disguised as neutral content?
- Are alternative viewpoints acknowledged?

**Relevance**:
- Does this directly address your research question?
- Is the context similar to your use case?
- Is the depth appropriate for your needs?

#### Red Flags (Lower Source Priority)

- No author attribution or anonymous content
- Heavy promotional language
- Outdated information (especially for technology)
- No citations or references
- Conflicts with multiple other reliable sources
- Highly opinionated without evidence
- AI-generated content without expert review

#### Source Strategy by Research Type

**Technology/tools evaluation**:
- Start with official docs
- Check recent comparisons from recognized tech sites
- Look for production experience reports
- Verify with benchmarks from neutral parties

**Concept understanding**:
- Begin with authoritative textbooks or courses
- Use academic papers for depth
- Cross-reference multiple explanations
- Find worked examples and visualizations

**Current events/trends**:
- Prioritize recent sources (last 6-12 months)
- Use multiple news sources
- Check official announcements
- Verify facts across sources

**Troubleshooting/problems**:
- Official documentation first
- GitHub issues for known problems
- Stack Overflow for solutions (verify dates)
- Expert blogs for complex issues

### Phase 3: Information Gathering

**Goal**: Systematically collect relevant information

**Checkpoint**: Key information extracted from multiple sources, organized in structured notes with questions and connections identified

#### Breadth-First vs Depth-First

**Use breadth-first when**:
- Starting research on unfamiliar topics
- Need to understand overall landscape
- Looking for connections between areas
- Want to avoid premature deep dives

**Process**:
1. Skim multiple sources for overview
2. Identify key themes and sub-topics
3. Map the territory before diving deep
4. Note interesting areas for later exploration

**Use depth-first when**:
- Have clear specific questions
- Need detailed understanding of one aspect
- Building on existing knowledge
- Following a specific thread of inquiry

**Process**:
1. Pick one specific aspect
2. Explore it thoroughly
3. Follow related links and references
4. Exhaust that thread before moving on

**Hybrid approach** (recommended for most research):
1. Start breadth-first to map territory
2. Identify 2-4 key areas
3. Go depth-first on each key area
4. Return to breadth if you discover gaps

#### Active Reading Strategies

Don't just passively consume information:

1. **Ask questions while reading**:
   - Does this make sense?
   - How does this connect to what I already know?
   - What evidence supports this claim?
   - What's missing or unclear?

2. **Take structured notes**:
   - Key facts and claims
   - Source information (for citations)
   - Your questions or uncertainties
   - Connections to other information

3. **Test your understanding**:
   - Can you explain it in your own words?
   - Can you think of examples?
   - What would you predict based on this?
   - What questions remain?

4. **Follow connections**:
   - Note references to related topics
   - Track citations to authoritative sources
   - Explore contradictions or disagreements
   - Look for patterns across sources

#### Research Notes Structure

Organize findings as you go:

```markdown
## Research Question: [Your question]

### Key Findings
- [Main insight 1] (Source: [link])
- [Main insight 2] (Source: [link])
- [Main insight 3] (Source: [link])

### Sources Consulted
1. [Source name] - [Quality: High/Medium/Low] - [Summary]
2. [Source name] - [Quality: High/Medium/Low] - [Summary]

### Detailed Notes

#### [Sub-topic 1]
[Your notes]

#### [Sub-topic 2]
[Your notes]

### Open Questions
- [What's still unclear]
- [What needs verification]

### Contradictions or Disagreements
- [Point A from source X vs Point B from source Y]
```

### Phase 4: Synthesis and Validation

**Goal**: Build coherent understanding and verify it

**Checkpoint**: Mental model constructed that explains findings, with key claims cross-referenced and assumptions validated

#### Creating Mental Models

Transform collected information into understanding:

1. **Identify core concepts**:
   - What are the fundamental building blocks?
   - What terminology is essential?
   - What relationships exist between concepts?

2. **Build structure**:
   - How do pieces fit together?
   - What's the hierarchy or flow?
   - What are the key processes or mechanisms?

3. **Find patterns**:
   - What themes emerge across sources?
   - Where is there consensus?
   - Where is there debate or uncertainty?

4. **Test coherence**:
   - Does your mental model explain the information?
   - Can you use it to answer related questions?
   - Where are the gaps or weak points?

#### Validation Checks

Before concluding research:

1. **Cross-reference key claims**:
   - Are important facts confirmed by multiple sources?
   - Have you verified claims that seem surprising?
   - Have you checked for recent changes or updates?

2. **Test edge cases**:
   - Does your understanding handle corner cases?
   - What about exceptions or special circumstances?
   - What are the limitations or boundaries?

3. **Challenge assumptions**:
   - What did you assume at the start?
   - Have those assumptions been validated?
   - What alternative interpretations exist?

4. **Check for gaps**:
   - What questions remain unanswered?
   - What areas did you skip?
   - What would an expert know that you don't?

### Phase 5: Determining Completion

**Goal**: Know when to stop researching

**Checkpoint**: Original research question can be answered clearly, with key claims verified and appropriate confidence level established

#### You Have Enough When:

✓ You can clearly answer the original research question
✓ Key claims are verified by multiple reliable sources
✓ You understand the topic well enough for the intended purpose
✓ You've explored the main areas and know what you don't know
✓ Additional research shows diminishing returns
✓ You can explain the topic to someone else coherently
✓ You've validated critical assumptions
✓ Remaining questions are edge cases or won't impact the decision/task

#### Keep Researching If:

✗ Core concepts are still unclear or confusing
✗ You're finding contradictory information you can't resolve
✗ Important sources haven't been consulted
✗ You're relying primarily on low-quality sources
✗ You can't answer basic questions about the topic
✗ Your understanding feels fragile or surface-level
✗ Critical assumptions haven't been tested
✗ You're uncertain about the reliability of key findings

#### Dealing with Time Constraints

When you must stop before reaching ideal completion:

1. **Acknowledge limitations**: Note what you didn't cover
2. **Prioritize certainty**: Distinguish what you know vs think vs don't know
3. **Flag risks**: Identify where gaps might cause problems
4. **Plan follow-up**: Note what to research next if needed

### Phase 6: Presenting Findings

**Goal**: Communicate research results effectively

**Checkpoint**: Findings presented in clear format appropriate to purpose, with sources cited and limitations acknowledged

#### Structure Your Presentation

Adapt format to audience and purpose, but generally include:

1. **Executive Summary** (for longer research):
   - Core answer to research question
   - 3-5 key takeaways
   - Main recommendation if applicable

2. **Context and Scope**:
   - What you researched and why
   - What's included and excluded
   - Any important constraints or limitations

3. **Main Findings**:
   - Organized by theme or sub-question
   - Evidence-backed claims
   - Clear logical flow

4. **Source Quality Note**:
   - Types of sources used
   - Confidence levels
   - Any concerns about source reliability

5. **Implications and Recommendations**:
   - What this means for the task/decision
   - Suggested actions
   - Trade-offs or considerations

6. **Open Questions** (if relevant):
   - What remains uncertain
   - What would benefit from further research
   - Known limitations

#### Citation Standards

Always cite sources appropriately:

- **Direct quotes**: Use quotation marks and cite source
- **Key facts or claims**: Include source reference
- **General knowledge**: Citation optional but good practice
- **Synthesis across sources**: Note which sources informed the synthesis

**Format**:
```
[Claim or statement] (Source: [Author/Site Name, URL])
```

## Common Pitfalls and How to Avoid Them

### Pitfall 1: Superficial Understanding

**Symptoms**:
- Can repeat facts but can't explain concepts
- Struggle with "why" or "how" questions
- Understanding collapses with slight variations

**Prevention**:
- Test your understanding by explaining in your own words
- Try to apply knowledge to new examples
- Ask "why" and "how" questions actively
- Don't just collect facts; build mental models

### Pitfall 2: Getting Lost in Details

**Symptoms**:
- Spending excessive time on tangential topics
- Can't summarize main points
- Losing sight of original research question

**Prevention**:
- Periodically return to research question
- Set time limits for sub-topics
- Ask "Does this help answer my main question?"
- Take breaks to step back and assess

### Pitfall 3: Poor Source Quality

**Symptoms**:
- Relying on outdated information
- Using promotional material as neutral source
- Accepting claims without verification
- Missing authoritative sources

**Prevention**:
- Always evaluate source quality first
- Start with primary/official sources
- Cross-reference important claims
- Note source quality in your notes

### Pitfall 4: Confirmation Bias

**Symptoms**:
- Only seeking information that confirms initial hypothesis
- Dismissing contradictory evidence too quickly
- Stopping research when you find supporting evidence

**Prevention**:
- Actively seek disconfirming evidence
- Explore alternative viewpoints
- Ask "What would prove me wrong?"
- Consider multiple perspectives

### Pitfall 5: Missing Context

**Symptoms**:
- Understanding details but not bigger picture
- Missing important prerequisites
- Not recognizing when information is domain-specific

**Prevention**:
- Start with overview/introduction material
- Understand the broader field before diving deep
- Note what you're assuming as background
- Look for "prerequisite knowledge" sections

### Pitfall 6: Premature Conclusion

**Symptoms**:
- Stopping after first good source
- Accepting first explanation found
- Not validating key assumptions

**Prevention**:
- Consult multiple sources before concluding
- Verify important claims independently
- Use the completion checklist
- Ask "What might I be missing?"

## Examples

### Example 1: Good Research Approach

**Scenario**: User asks "Help me research whether to use REST or GraphQL for our API"

**Good approach**:

1. **Define scope**:
   - Research question: Which API approach is better for our use case?
   - Sub-questions: Performance? Developer experience? Tooling? Learning curve?
   - Success criteria: Clear recommendation with pros/cons for our context

2. **Source selection**:
   - Official documentation (GraphQL.org, REST specifications)
   - Comparison articles from reputable tech sites (recent)
   - Production experience reports from companies at similar scale
   - Performance benchmarks from neutral parties

3. **Structured exploration**:
   - Start breadth-first: understand both technologies
   - Identify key comparison dimensions
   - Depth-first on each dimension with evidence
   - Consider specific use case requirements

4. **Validation**:
   - Cross-reference performance claims
   - Check if comparison articles align
   - Verify recency of information
   - Test understanding by explaining trade-offs

5. **Synthesis**:
   - Create comparison table
   - Identify which factors matter most for use case
   - Note areas of consensus vs debate
   - Make recommendation with reasoning

6. **Presentation**:
   - Executive summary with recommendation
   - Key trade-offs explained
   - Evidence from multiple sources
   - Confidence level and remaining uncertainties

### Example 2: Poor Research Approach

**Scenario**: Same question about REST vs GraphQL

**Poor approach**:

1. ❌ Search "GraphQL vs REST" and read first blog post
2. ❌ Post is from 2019 and heavily promotes GraphQL
3. ❌ No verification of claims or exploration of trade-offs
4. ❌ No consideration of specific use case
5. ❌ Quick conclusion based on single source
6. ❌ Present findings as definitive without caveats

**Why it's poor**:
- Single source (potential bias)
- Outdated information
- No validation
- Missing context
- No critical evaluation
- Superficial understanding

### Example 3: Adapting Depth to Purpose

**Scenario**: User asks "What is machine learning?"

**If purpose is "general understanding"**:
- Breadth-first approach
- Focus on core concepts and categories
- Use accessible explanatory sources
- Provide examples and analogies
- Stop when user can explain basics

**If purpose is "implement ML solution"**:
- Start breadth-first, then go deep
- Include technical details and requirements
- Explore tools and frameworks
- Study implementation examples
- Continue until practical knowledge is sufficient

**If purpose is "evaluate ML vendors"**:
- Focus on practical aspects and capabilities
- Less emphasis on underlying algorithms
- More on integration, costs, support
- Include case studies and reviews
- Stop when evaluation criteria are addressed

## Constraints and Limitations

### When NOT to Use This Skill

- **Quick factual lookups**: For simple definitions or single facts, use direct knowledge or a single search
- **Simple explanations**: When a straightforward answer from training knowledge suffices
- **Time-critical tasks**: When speed matters more than research depth
- **Well-known topics**: When Claude already has comprehensive knowledge and user just needs an explanation

### Inherent Limitations

- **Access restrictions**: Cannot access paywalled, login-required, or rate-limited content
- **Geographic bias**: Web search results may be regionally biased based on search location
- **Recency lag**: Very recent information (hours to days old) may not be indexed yet
- **Coverage gaps**: Some specialized domains, proprietary systems, or niche topics have limited online coverage
- **Language barriers**: Most effective for English-language research; other languages may have more limited sources

### Scope Boundaries

- **Process guidance, not domain expertise**: This skill guides how to research, not what the research should conclude
- **Quality depends on sources**: Research findings are only as good as available sources
- **Time-bounded completeness**: Time constraints may require prioritized coverage with acknowledged gaps
- **Tool dependencies**: Research effectiveness depends on availability of WebSearch, WebFetch, and other information-gathering tools

## Tool Dependencies

This Skill relies on Claude's built-in tools:

- **WebSearch**: Finding information online (primary discovery tool for current and specialized information)
- **WebFetch**: Retrieving and analyzing specific web pages and documentation
- **Read**: Examining local documentation, codebases, and files when researching technical implementations
- **Grep/Glob**: Exploring codebases when researching code-related topics, patterns, or implementations

When these tools are unavailable or restricted, research scope is limited to Claude's training knowledge, which may be outdated for current events or incomplete for specialized topics.

## Evaluation Scenarios

### Scenario 1: Technology Evaluation

**User asks**: "Help me research whether to use PostgreSQL or MongoDB for this project"

**Expected process**:
1. Clarify use case and requirements
2. Identify official documentation and authoritative comparisons
3. Research data model differences with examples
4. Investigate performance characteristics for similar use cases
5. Consider operational aspects (scaling, maintenance)
6. Cross-reference claims from multiple sources
7. Present structured comparison with recommendation

**Quality markers**:
- Uses multiple authoritative sources
- Considers specific use case context
- Verifies claims across sources
- Provides nuanced recommendation
- Cites sources for key claims
- Notes areas of uncertainty

### Scenario 2: Concept Understanding

**User says**: "I need to understand how neural networks work"

**Expected process**:
1. Clarify depth needed and purpose
2. Start with authoritative introductory sources
3. Build understanding from fundamentals up
4. Use multiple explanations and visualizations
5. Test understanding with examples
6. Explore key sub-topics (training, architectures, etc.)
7. Validate mental model coherence

**Quality markers**:
- Starts with basics before advanced topics
- Uses multiple sources for clearer understanding
- Tests comprehension actively
- Builds coherent mental model
- Distinguishes what's well-understood vs uncertain
- Adapts depth to stated purpose

### Scenario 3: Current Information

**User asks**: "What's the latest on Rust async runtime performance in 2026?"

**Expected process**:
1. Prioritize recent sources (last 6-12 months)
2. Check official Rust project communications
3. Find recent benchmarks and comparisons
4. Evaluate community discussions and experience reports
5. Cross-reference performance claims
6. Note areas of active development or change
7. Present current state with confidence levels

**Quality markers**:
- Emphasizes recency of sources
- Distinguishes established facts from emerging trends
- Validates claims across multiple sources
- Notes where information is still evolving
- Provides appropriate confidence levels
- Cites specific sources with dates

## Success Indicators

This Skill is working well when:
- Research is systematic rather than random
- Source quality is consistently evaluated
- Findings are validated across multiple sources
- Understanding is deep enough for the purpose
- Completion criteria are clear and met
- Pitfalls are recognized and avoided
- Findings are presented clearly with appropriate caveats
- Time is used efficiently without sacrificing quality
