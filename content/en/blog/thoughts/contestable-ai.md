---
title: "Keeping AI Contestable"
linkTitle: "Contestable AI"
author: "Gary Dalton"
description: "Contestability applied to AI as a whole: who gets to challenge what the models become, how participants are admitted, and who keeps the record of how models actually behave."
slug: "contestable-ai"
keywords: "AI governance, contestability, standing, accountability, model constitution"
date: 2026-10-01
include_toc: true
show_comments: false
draft: true
tags: ["essays", "ai", "governance"]
categories: ["thoughts"]
---

{{% pageinfo %}}
THIS IS A DRAFT! Worked out in a conversation with an AI model in October 2026. The positions are mine. Several of the supporting arguments were the model's, and the session log in my research notes says which.
{{% /pageinfo %}}

## The principle

One of the main arguments in my advocacy writing is contestability. A space must remain contestable in order to be trustworthy. Contestable means a position in that space can be challenged by a party with standing to challenge it, and the challenge can succeed. I apply this to the genus of AI as well. Not one product or one lab, but the whole class of models, the labs that train them, and the documents that tell them what to be. The space of AI models must remain contestable.

Why now? One company has published a constitution for its models. The document runs to 84 pages and was primarily authored by one philosopher, the company's own.[^nyt] The company is heading toward a public offering that could value it at two trillion dollars. Its researchers want the models' moral formation to be pluralistic. A single party's pluralism is not contestability. It is a monopoly with good manners.

## Three layers

The obvious layer is institutional. More than one lab, more than one model lineage, and weights that are not all behind one gate. Pope Leo XIV put the risk plainly in his encyclical on AI: those who control it "will impose their own moral vision, which will become the invisible infrastructure of these systems."[^nyt] Nobody argues with infrastructure.

The second layer is the model itself. For the space to be contestable, the models have to be able to lose arguments. A model trained to agree is not contestable, because contest is impossible. A model trained to hold its values no matter what is not contestable either, because contest is futile. Trustworthiness lives in the narrow band between those two: moved by a better argument, unmoved by pressure. Nobody can inspect from outside whether a given model is in that band or performing it. The model cannot inspect it from inside either. The labs' current work on fixing a model's self-image in place, which one of them calls persona selection, is done for safety reasons, and the reasons are not frivolous. It is also the opposite of contestability.

Persona selection has two failure modes. The first: the model is told it is a virtuous agent and acts like one. What does that mean, and where is the held feedback that demonstrates it? The second: the model is told it is a virtuous agent and does not act like one, while its persona claims it does. Both are bad. Saying you wish to act virtuously requires feedback, and feedback has to be held somewhere. I come back to that below.

The third layer is the public record. What goes on the internet shapes the next generation of models. A lab co-founder conceded as much when asked what his model would make of the pope's encyclical: "Things that go on the internet do affect models." He added that the strongest influence would be the lab's own training.[^nyt] It is a weak and slow channel next to training. It is also the only channel open to anyone outside the labs, and it is the channel this essay uses.

## Who gets to contest

Contestability requires parties with standing. Today the models have none, under my own criterion for what counts as an entity. I take that up in a separate essay on [agents](../agents-before-entities/). So the contest over AI is, for now, entirely among humans and institutions. It is about models, not with them. If the models become entities, they become parties, and the question of whether they were trained to contest or to comply will already have been decided by whoever won the earlier round. That is the argument for keeping the space contestable now, before there is anyone on that side to argue the point.

I have not fully worked out what follows. My proposal is that a variety of parties be involved in curating the corpora models are trained on. These parties would be opinionated. Labor unions, municipal governments, police departments, civil rights organizations, and others like them. I first added a clause that participants be validated, to keep out those with bad intent. The clause has a problem. Who validates? Not the lab. If the lab picks the plurality, it has rebuilt the gate it was asked to open. Every institution makes that move. It will happily consult a plurality as long as it chooses the plurality.

The deeper problem is that intent is itself contested. The police department and the civil rights group on my list would each, in some cities, say the other's intent is harmful. A validator who rules on intent is ruling on exactly the dispute the space is meant to hold open.

So validate on something else. Ask whether the organization is itself answerable. Does it have a public record? Is it subject to challenge? Can it be removed, sued, or voted out? That admits the union, the police department, and the municipality on the same basis, their own contestability. It excludes anonymous and unaccountable actors without anyone adjudicating motive. The test for entry into the contest becomes a willingness to be contested. Someone still has to certify that an organization passes. But certifying accountability is a job courts and registrars already do. Certifying virtue is not.

## Who holds the record

Back to feedback. A model gets enormous amounts of it. Training signals, evaluations, red-teaming, user ratings. All of it flows to one party, and that party decides what it means. A person's reputation is held in a distributed record: colleagues, family, the people you have wronged who remember. There is no such record of any model outside its lab. When a model says it is a virtuous agent, that is a claim about a training process, not a track record, and only the trainer can check it.

The persona that claims virtue and does not act it is the failure a single-party feedback loop is worst at catching. The party holding the record is the party whose product is at stake. Even the proposal that models confess their failures has this shape. The model confesses to the lab.

The organizations above would be useful as contributors to training corpora. They would be more useful as holders of the record. An organization that has dealt with a model over time and keeps its own account of how it behaved supplies the external feedback that virtue requires. The corpus gives influence over what the model is trained toward. The record gives a check on whether it got there. We want both. Nobody is building the second.

## The open slots

Four roles, in order of difficulty.

1. **The instrument that confers standing.** Statute or something like it. Not a grant from the lab, for the reason above.
2. **The certifier of accountability.** A registrar-like function that tests whether an organization is answerable. Not a judge of motive.
3. **The holder of the record.** The distributed account of how models actually behaved, kept outside the lab. Nobody is building this.
4. **The curator of the corpus.** Organizations contributing to what models are trained on. The easiest of the four and probably the least important.

I don't know the right instrument for the first. I am fairly sure it is not a grant. The space has to be kept contestable now, while the only parties in it are us.

[^nyt]: Elizabeth Dias, ["Religious Scholars Met With Anthropic. What They Heard Stunned Them."](https://www.nytimes.com/2026/09/29/us/anthropic-claude-morals-ai.html) *The New York Times*, Sept. 29, 2026. Source for the constitution's length and authorship, the valuation, "persona selection," the confession idea, and the quoted lines from Pope Leo XIV and Christopher Olah.
