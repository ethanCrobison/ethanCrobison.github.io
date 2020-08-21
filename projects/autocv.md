---
layout: default
cvinfo:
    type: Personal
    org: PERSONAL PROJECT
    time: "SPRING 20"
    blurb: "Use Jekyll front-matter to generate a resume and CV."
    tags:
        - Automation
title: "Auto CV: Set-and-forget for Professional Documentation"
---

{{ page.cvinfo.date }}

{{ page.cvinfo.title }}

I started a pretty substantial job search around the time of this page's
original creation (mid 2020). This meant that I needed to create and
update everyone's two favorite documents, my CV and my resume. Of
course, a resume's details are ostensibly a subset of a CV's, which
means that I thought the sensible thing to do was to whip up a CV for
the first time in my life and delete accordingly to create a resume.
The contents of a CV are dynamically compiled as one completes projects,
earns new qualifications, &c. I have two problems with this:

__1. I'm a touch reactive about updating my professional records.__ I
almost never update my resume/CV until it's time to do a big job search.
This means that an already dreadful process is made worse, and I'm
disinclined to do it.

__2. I have multiple "canonical" sources of information about myself.__
Lots of people have a CV and a website and a resume, at least, which
means that lots of people have three (3!) places where they have to
update things. I can barely handle one (1!) place!

Enter AutoCV, a tool for scraping my website's frontmatter for certain,
specially formatted information, then automatically creating a
correctly-formatted YAML file _with_ that information. Then, I write a
pair of LaTeX templates for a CV and a resume and build both with
pandoc. Bam! All three documents use the same ground truth. Now, I write
project/skill information down in one place, and it gets automagically
transformed into my professional documentation, and recruiters are none
the wiser that I'm a lazy bum who only wrote his information down once
(twice, if you count uploading a resume and then re-entering its info on
the next page).

# Section Title

- Personal details and contact information.
- Education and qualifications. Be sure to include the names of
  institutions and dates attended in reverse order: Ph.D., Masters,
  Undergraduate.

- Work experience/employment history. The most widely accepted style of
  employment record is the chronological curriculum vitae. Your career
  history is presented in reverse date order starting with the most
  recent appointment. More emphasis/information should be placed on your
  most recent jobs.

- Skills. Include computer skills, foreign language skills, and any
  other recent training that is relevant to the role applied for.
- Training / Graduate Fieldwork / Study Abroad
- Dissertations / Theses
- Research experience
- Teaching experience
- Publications
- Presentations, lectures, and exhibitions
- Grants, scholarships, fellowships, and assistantships
- Awards and honors
- Technical, computer, and language skills
- Professional licenses, certifications, and memberships
