classdef ScriptTab < handle
    properties
        Name
        ConstructionGroup;
        Script;
    end
    
    methods
        function obj = ScriptTab(name)
            if nargin == 0
                obj.Name = 'woodpile';
                obj.ConstructionGroup = 1;
                obj.Script = strcat(['deleteall; \n radius = %%pile radius%%; \n pile_a = %%pile a%%; \n'...
                    'n_high = %%n high%%; \n addcircle; \n set("name","wood"); \n '...
                    'set("material",material); \n if(get("material")=="<Object defined dielectric>")  {set("index",index); } \n'...
                    'setnamed("wood","radius",radius); \n setnamed("wood","z",0); \n setnamed("wood","z span", pile_a); \n'...
                    'setnamed("wood","first axis","x"); setnamed("wood","rotation 1",90); \n setnamed("wood","x",-pile_a/2); \n'...
                    'setnamed("wood","y",0); \n select("wood"); \n copy(pile_a); \n addstructuregroup; \n set("name","row1"); \n setnamed("row1","z",0); \n'...
                    'select("wood"); \n addtogroup("row1"); \n select("row1"); \n copy(0, 0, 2*radius); \n set("first axis", "z"); \n'...
                    'set("rotation 1", 90); \n set("name", "row2"); \n select("row1"); \n copy(pile_a/2,0,4*radius); \n  set("name","row3"); \n'...
                    'select("row2"); \n copy(0, pile_a/2, 4*radius); \n set("name","row4"); \n addstructuregroup; \n'...
                    'set("name","layer0"); \n selectpartial("row"); \n addtogroup("layer0"); \n setnamed("layer0","z",0); \n'...
                    'for (i=1:n_high) { \n select("layer0"); \n copy(0, 0, 8*(i-1)*radius); \n filename = "layer"+num2str(i); \n'... 
                    'set("name",filename); \n } \n select("layer0"); \n delete; \n set("z", radius);']);
                    
            else
                obj.Name = name;
                obj.ConstructionGroup = 1;
                obj.Script = strcat(['deleteall; \n radius = %%pile radius%%; \n pile_a = %%pile a%%; \n'...
                    'n_high = %%n high%%; \n addcircle; \n set("name","wood"); \n '...
                    'set("material",material); \n if(get("material")=="<Object defined dielectric>")  {set("index",index); } \n'...
                    'setnamed("wodd","radius",radius); \n setnamed("wood","z",0); \n setnamed("wood","z span", pile_a);\ n'...
                    'setnamed("wood","first axis","x"); setnamed("wood","rotation 1",90); \n setnamed("wood","x",-pile_a/2); \n'...
                    'setnamed("wood","y",0); \n select("wood"); \n copy(pile_a); \n addstructuregroup; \n set("name","row1"); \n setnamed("row1","z",0); \n'...
                    'select("wood"); \n addtogroup("row1"); \n select("row1"); \n copy(0, 0, 2*radius); \n set("first axis", "z"); \n'...
                    'set("rotation 1", 90); \n set("name", "row2"); \n select("row1"); \n copy(pile_a/2,0,4*radius); \n  set("name","row3"); \n'...
                    'select("row2"); \n copy(0, pile_a/2, 4*radius); \n set("name","row4"); \n addstructuregroup; \n'...
                    'set("name","layer0"); \n selectpartial("row"); \n addtogroup("layer0"); \n setnamed("layer0","z",0); \n'...
                    'for (i=1:n_high) { \n select("layer1"); \n copy(0, 0, 8*(i-1)*radius); \n filename = "layer"+num2str(i); \n'... 
                    'set("name",filename); \n } \n select("layer0"); \n delete; \n set("z", radius);']);
            end
        end
        
        function set.ConstructionGroup(obj, constructionGroup)
            obj.ConstructionGroup = set_check_box(constructionGroup);
        end   
    end
    
    methods(Static)
        test();
    end
end