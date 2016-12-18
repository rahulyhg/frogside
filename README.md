# frogside

Frogside aims to become a YAML-based flat-file CMS written in
PHP to make it available to low-budget projects not able to
buy expensive hosting services.

**Why another PHP CMS**

Developers, designers and editors have so different requirements
to what they expect from a good content management system. I am
one of them, expecting a CMS to be:

- flexible for the **developer**, not the editor. In my expirience, I as a
developer am the one who creates and administrates the look and structure
of the website. The client always and only wants to edit and create content.
- So I always was using Rails and created templates, commonly 1-6 different,
the editor, creating a new page, selected the template, got all the blocks in
the right (what we agreed on in the creation-phase of the website) order.
- light-weight in terms of server costs (mem, space, complexity)
- simple plugin system
- in-page editing
- block-aware content

CMS, I know, can do most of the requirements, but solve them in a way, the
editor is able to destroy

## core features & implementation status

### PHP backend

- [ ] php api to manage file uploads, page changes and user authentication
- [ ] YAML files to discribe a webpage
  - [ ] blocks for different types of sections
- [ ] plugin system
  - [ ] for the block types
  - [ ] for middleware integrations

### ReactJS frontend

- [ ] authentication
- [ ] user management
- [ ] page management
  - [ ] in-page editing blocks with plugin system
