%/usr/lib/swi-prolog/lib/x86_64-linux
#:- asserta(library_directory('/home/ailab/cmProlog/knowrob_library')).
#:- asserta(library_directory('/home/ailab/cmProlog/agent')).
#%:- asserta(library_directory('C:/Users/jaeyun/Desktop/robot/social_demo/ContextManager/knowrob_library')).
#%:- asserta(library_directory('C:/Users/jaeyun/Desktop/robot/social_demo/ContextManager/agent')).
#:- use_module(library('semweb/rdf_db')).

:- asserta(library_directory('/home/Downloads/190816_cmtm_code/cmProlog/knowrob_library')).
:- asserta(library_directory('/home/Downloads/190816_cmtm_code/cmProlog/agent')).
:- use_module(library('semweb/rdf_db')).

% knowrob_objects.owl / comp_spatial.owl# / comp_temporal.owl

:- rdf_load(library(knowrob)).
:- rdf_load(library(owl)).
:- rdf_load(library(computable)).
:- rdf_load(library(knowrob_objects)).
:- rdf_load(library(comp_spatial)).
:- rdf_load(library(comp_temporal)).
:- rdf_load(library(arbi101)).
:- use_module(library('semweb/rdf_edit')).
:- use_module(library('semweb/rdfs')).
:- use_module(library('semweb/rdf_portray')).

:- use_module(library('owl')).
:- use_module(library('owl_parser')).
:- use_module(library('rdfs_computable')).

:- use_module(library('util')).
:- use_module(library('classifiers')).
:- use_module(library('comp_similarity')).
:- use_module(library('knowrob_owl')).

:- use_module(library('owl_export')).
:- use_module(library('knowrob_cad_parser')).

:- use_module(library('comp_spatial')).
:- use_module(library('comp_temporal')).

:- use_module(library('knowrob_objects')).
:- use_module(library('knowrob_perception')).
:- use_module(library('knowrob_coordinates')).

:- use_module(library('prolog/arbi_comp_robotState')).
:- use_module(library('prolog/arbi_comp_temporal')).
:- use_module(library('prolog/predicate_')).
:- use_module(library('prolog/affordance')).
:- use_module(library('prolog/arbi_convenient_service')).
:- use_module(library('prolog/global_variable')).
%:- rdf_load(library(owl/semanticmap_demo)).
%:- rdf_load(library(owl/semanticmap_demo_gazebo)).
:- rdf_load(library(owl/jaco_model)).
%:- rdf_load(library(owl/object_demo)).
%:- rdf_load(library(owl/object_demo_gazebo)).
:- rdf_load(library(owl/object_demo_tables)).
:- rdf_load(library(owl/arbi)).
:- rdf_load(library(owl/arbi_comp_robotState)).
:- rdf_load(library(owl/arbi_comp_spatial)).
:- rdf_load(library(owl/arbi_comp_temporal)).

:- rdf_db:rdf_register_ns(rdf,    'http://www.w3.org/1999/02/22-rdf-syntax-ns#',     [keep(true)]).
:- rdf_db:rdf_register_ns(rdfs,    'http://www.w3.org/2000/01/rdf-schema#',     [keep(true)]).
:- rdf_db:rdf_register_ns(owl,     'http://www.w3.org/2002/07/owl#',            [keep(true)]).
:- rdf_db:rdf_register_ns(knowrob, 'http://knowrob.org/kb/knowrob.owl#',     [keep(true)]).
:- rdf_db:rdf_register_ns(arbi, 'http://www.arbi.com/arbi#',     [keep(true)]).
:- rdf_db:rdf_register_ns(comp_spatial, 'http://knowrob.org/kb/comp_spatial.owl#',     [keep(true)]).


% convenience: set some Prolog flags in order *not to* trim printed lists with [...]
:- set_prolog_flag(toplevel_print_anon, false).
:- set_prolog_flag(toplevel_print_options, [quoted(true), portray(true), max_depth(0), attributes(portray)]).

:- set_prolog_flag(float_format, '%.12g').
