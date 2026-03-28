---
title: "Secondary Evolutionary Dynamics"
linkTitle: "Evolution II"
weight: 26
author: "Gary Dalton"
resources:
- src: ""
  title: ""
  params:
    byline: "Photo: Gary Dalton / CC-BY-CA"
slug: ""
image: ""
keywords: ""
date: 2026-03-28
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
---

{{% pageinfo %}}
THIS IS A DRAFT!
{{% /pageinfo %}}

The core evolutionary loop — inherit, vary, select — does not fully explain what persists in a system. Several secondary dynamics shape the evolutionary landscape in ways that are non-obvious and often counterintuitive. These mechanisms determine why some properties endure despite conferring no advantage, why adaptation is messier than simple optimization, and why entirely foreign information can suddenly enter a lineage.

---

## Neutral Drift: Persistence Without Selection

Not all variation faces meaningful selection pressure. Some mutations have effects so slight that the system's forces cannot distinguish them from the background.

* **Core Concept:** **Neutral drift** is the persistence and spread of mutations that have negligible effect on fitness — they are neither adaptive nor maladaptive enough to be selected for or against. In the model's terms, these are property variations that generate forces too weak to meaningfully alter the object's interaction outcomes within the current context.
* **Analogy:** Spelling variations that do not affect comprehension. "Colour" and "color" coexist because neither is functionally superior — the difference falls below the threshold of communicative selection.
* **Mechanism:** Neutral mutations produce sub-threshold forces relative to the system's aggregation function. They are drowned out by stronger forces acting on the object. Over time, neutral drift accumulates and creates a hidden reservoir of variation within a population. This reservoir is invisible to selection in the current context, but it constitutes a pre-existing supply of diversity that may become relevant if the context shifts — a phase change can make formerly neutral variations suddenly visible to selection.

Neutral drift also serves as a generational clock: because it accumulates at a roughly steady rate independent of selection, it provides a measure of generational time.

Examples:
- Biological: Synonymous codon substitutions in DNA that produce the same protein.
- Corporate: Minor process variations across franchise locations that have no measurable effect on output quality.
- Linguistic: Regional pronunciation differences that do not impede mutual comprehension.
- Technological: Refactoring code in ways that do not change functionality but alter internal structure.

**Empirical case — serial cloning and the accumulation of invisible damage:**
Wakayama et al. (2026) serially cloned mice through 58 consecutive generations using somatic cell nuclear transfer — a process that bypasses sexual recombination entirely. By the final generations, the cloned lineage had accumulated roughly three times more mutations than naturally bred mice. Most of these mutations were individually sub-threshold — each too slight to trigger selection. The lineage was functional for many generations before the accumulated burden crossed a critical point: later-generation clones suffered reduced fertility, impaired development, and elevated mortality.

This is neutral drift without a correction mechanism. Sexual recombination normally purges accumulated drift by shuffling the inheritance structure each generation — breaking up clusters of mildly deleterious mutations. Without it, the cloned lineage illustrates how a hidden reservoir of variation can shift from invisible to fatal. Notably, epigenetic abnormalities did *not* worsen over generations — the contextual tuning channel remained stable while the primary inheritance channel degraded, confirming their independence as information pathways.

---

## Spandrels: Structural Byproducts

Not every persistent feature of a system is an adaptation. Some properties arise as structural byproducts of other selected properties and persist because they are physically, logically, or structurally inseparable from the adaptive trait.

* **Core Concept:** **Spandrels** (borrowing from Gould and Lewontin's architectural metaphor) are properties that exist not because they were selected for, but because they are coupled to something that was. They are a consequence of structure, not of fitness.
* **Analogy:** The triangular spaces (spandrels) at the junction of arches in a cathedral. They arise from the geometry of the arch, not from any design intent — yet they can be decorated and appear purposeful.
* **Mechanism:** When a mutation alters an object's properties in an adaptive way, it may simultaneously create or alter other properties as a structural consequence. Because the object's properties are interconnected — not independent parameters — changing one pulls on others. The secondary properties persist because severing them from the adaptive property would require altering the very structure that makes the primary property work.

Spandrels are important for the model because they are a reminder that this is a computational system, not a purposeful one. Persistence does not imply optimization. The system does not select for each property independently; it selects for configurations.

Examples:
- Biological: The redness of blood is a spandrel of hemoglobin's oxygen-carrying chemistry, not an adaptation for color.
- Architectural: The original Gould and Lewontin example — the decorative spaces between arches in San Marco.
- Cultural: The association of weekdays with planetary names is a structural byproduct of historical astronomical naming conventions.
- Institutional: Corporate bureaucratic procedures that persist not because they are efficient but because they are structurally coupled to compliance requirements that are.

---

## Pleiotropy: One Change, Many Effects

A single mutation does not necessarily affect only one property. Objects have internal structure, and properties are interconnected.

* **Core Concept:** **Pleiotropy** is the phenomenon where a single mutation or inherited property change affects multiple properties of the descendant object simultaneously. One input to the inheritance channel propagates through the object's internal structure and produces multiple outputs.
* **Analogy:** A single policy change — say, imposing a trade tariff — simultaneously affects domestic manufacturing, consumer prices, international relations, and supply chain logistics. One input, many consequences.
* **Mechanism:** This connects directly to force aggregation. A single mutational "force" applied to the inheritance channel is aggregated across the object's internal property structure. The aggregation function determines how the single input distributes across multiple outputs. Pleiotropy creates a tension: a mutation that is adaptive for one property may be simultaneously maladaptive for another. Selection operates on the **net** fitness effect across all affected properties, which makes the fitness landscape much more complex and rugged — changing one property moves the object's position along multiple dimensions simultaneously.

Examples:
- Biological: The gene causing sickle cell anemia also confers malaria resistance — one genetic change, two dramatically different phenotypic effects.
- Corporate: A decision to cut costs by reducing quality control simultaneously affects product quality, customer satisfaction, employee morale, and regulatory compliance.
- Technological: Increasing encryption key length simultaneously improves security but degrades performance and increases energy consumption.
- Political: Universal basic income simultaneously affects labor markets, poverty rates, inflation, and social cohesion.

---

## Genetic Hitchhiking: Proximity-Based Co-Inheritance

The inheritance channel does not transmit properties one at a time in isolation. It transmits structured blocks. Properties that are proximate within this structure tend to be co-transmitted.

* **Core Concept:** **Genetic hitchhiking** is the phenomenon where a property that is not itself under selection is co-inherited with a nearby property that IS under selection, simply because of their proximity in the inheritance structure. When selection favors one property in a block, all neighboring properties in that block come along for the ride.
* **Analogy:** A corporate acquisition. When a successful product line is acquired, the acquiring company also inherits the product line's organizational culture, supplier relationships, and technical debt — these hitchhike along with the desired asset.
* **Mechanism:** This connects to the Nearest Neighbor Principle applied within the inheritance structure: proximity determines coupling. Properties that are "near" each other in the inherited property-set tend to be co-transmitted because the inheritance channel copies contiguous blocks rather than individual parameters. Hitchhiking can preserve neutral or even mildly maladaptive properties if they are proximate to strongly adaptive ones.

Examples:
- Biological: Genes physically close on a chromosome tend to be inherited together (linkage); a neutral gene next to a highly selected gene sweeps to high frequency.
- Cultural: When a culture adopts a useful technology from another culture, it often also adopts associated aesthetic preferences, terminology, and social practices.
- Legal: When a popular constitutional amendment is ratified, it may carry along secondary clauses that would not have passed on their own merits.
- Technological: Adopting a software framework brings along its dependency tree, architectural opinions, and community conventions — not just the desired functionality.

---

## Horizontal Transfer: Lateral Acquisition

Standard inheritance flows vertically — parent to descendant. But objects can also acquire properties laterally from unrelated objects through their existing relationships.

* **Core Concept:** **Horizontal transfer** is the acquisition of heritable properties from an object that is NOT a lineal ancestor — from a neighbor rather than a parent. This dramatically expands the pool of available variation beyond what mutation alone can provide.
* **Analogy:** Japan's Meiji Restoration. In the span of decades, Japan adopted Western industrial, military, and educational structures wholesale — grafting functional property-sets from an entirely unrelated civilizational lineage onto its own.
* **Mechanism:** Horizontal transfer is enabled by the model's existing Relationships and the Nearest Neighbor Principle. "Nearest" is defined not just spatially but by affiliation, memory, and other object properties. This means any object connected by a relationship is a potential source of heritable information — not just parents. Horizontal transfer accelerates evolution by allowing objects to acquire pre-tested, functional property-sets from other lineages, bypassing the slow accumulation of random mutation. It also means that evolutionary lineages are not strict trees — they are networks (reticulate evolution).

Specific mechanisms include:
- **Viral insertion:** An external agent embeds its information into the host object's property-set, where it becomes inheritable. In biology, roughly 8% of the human genome is retroviral in origin.
- **Transposition:** Information that moves within an object's property structure, sometimes carrying functional elements to new locations. Barbara McClintock's "jumping genes."
- **Symbiogenesis:** Wholesale incorporation of one object into another. Mitochondria — once free-living bacteria — are now integral components of eukaryotic cells.

Examples:
- Biological: Bacteria acquiring antibiotic resistance genes from other species through plasmid transfer.
- Technological: A software project incorporating a library from a completely unrelated project.
- Cultural: The global adoption of Arabic numerals — a mathematical property-set transferred laterally across unrelated civilizational lineages.
- Institutional: A corporation adopting management practices (Agile, Six Sigma) invented by an unrelated organization.

---

## Comparative Summary

| Mechanism | Core Idea | Analogy | Primary UM Connection |
| :--- | :--- | :--- | :--- |
| **Neutral Drift** | Sub-threshold variation accumulates invisibly. | Spelling variations. | Force Aggregation, Context |
| **Spandrels** | Structural byproducts of adaptive coupling. | Cathedral arch spaces. | Objects (property structure), Emergence |
| **Pleiotropy** | One change propagates to many properties. | Trade tariff ripple effects. | Force Aggregation, Objects |
| **Genetic Hitchhiking** | Proximity-based co-inheritance. | Corporate acquisition baggage. | Nearest Neighbor Principle |
| **Horizontal Transfer** | Lateral acquisition from non-ancestors. | Meiji Restoration. | Nearest Neighbor, Relationships, Forces |
