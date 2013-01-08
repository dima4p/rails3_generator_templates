require 'spec_helper'

<% def params; "{'these' => 'params'}" end -%>
<% module_namespacing do -%>
describe <%= controller_class_name %>Controller do

  def <%= mock_file_name %>(stubs={})
    @<%= mock_file_name %> ||= mock_model(<%= class_name %>, stubs).as_null_object
  end

  before :each do
    controller.stub!(:current_user).and_return(current_user)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # <%= controller_class_name %>Controller. Be sure to keep this updated too.
  def valid_session
    {}
  end

<% unless options[:singleton] -%>
  describe "GET index" do
    it "assigns all <%= table_name.pluralize %> as @<%= table_name.pluralize %>" do
      get :index, valid_session
      assigns(:<%= table_name %>).should be_a_kind_of(ActiveRecord::Relation)
    end
  end

<% end -%>
  describe "GET show" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= stub orm_class.find(class_name, "37".inspect) %> { <%= mock_file_name %> }
      get :show, {:id => "37"}, valid_session
      assigns(:<%= ns_file_name %>).should be(<%= mock_file_name %>)
    end
  end

  describe "GET new" do
    it "assigns a new <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= stub orm_class.build(class_name) %> { <%= mock_file_name %> }
      get :new, valid_session
      assigns(:<%= ns_file_name %>).should be(<%= mock_file_name %>)
    end
  end

  describe "GET edit" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= stub orm_class.find(class_name, "37".inspect) %> { <%= mock_file_name %> }
      get :edit, {:id => "37"}, valid_session
      assigns(:<%= ns_file_name %>).should be(<%= mock_file_name %>)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= stub orm_class.build(class_name, params) %> { <%= mock_file_name(:save => true) %> }
        post :create, {:<%= ns_file_name %> => <%= params %>}, valid_session
        assigns(:<%= ns_file_name %>).should be(<%= mock_file_name %>)
      end

      it "redirects to the created <%= ns_file_name %>" do
        <%= stub orm_class.build(class_name) %> { <%= mock_file_name(:save => true) %> }
        post :create, {:<%= ns_file_name %> => {}}, valid_session
        response.should redirect_to(<%= table_name.singularize %>_url(<%= mock_file_name %>))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= stub orm_class.build(class_name, params) %> { <%= mock_file_name(:save => false) %> }
        post :create, {:<%= ns_file_name %> => <%= params %>}, valid_session
        assigns(:<%= ns_file_name %>).should be(<%= mock_file_name %>)
      end

      it "re-renders the 'new' template" do
        <%= stub orm_class.build(class_name) %> { <%= mock_file_name(:save => false) %> }
        post :create, {:<%= ns_file_name %> => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested <%= ns_file_name %>" do
        <%= stub orm_class.find(class_name, "37".inspect) %> { <%= mock_file_name %> }
        mock_<%= should_receive orm_instance.update_attributes(params) %>
        put :update, {:id => "37", :<%= ns_file_name %> => <%= params %>}, valid_session
      end

      it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= stub orm_class.find(class_name) %> { <%= mock_file_name(:update_attributes => true) %> }
        put :update, {:id => "1"}, valid_session
        assigns(:<%= ns_file_name %>).should be(<%= mock_file_name %>)
      end

      it "redirects to the <%= ns_file_name %>" do
        <%= stub orm_class.find(class_name) %> { <%= mock_file_name(:update_attributes => true) %> }
        put :update, {:id => "1"}, valid_session
        response.should redirect_to(<%= table_name.singularize %>_url(<%= mock_file_name %>))
      end
    end

    describe "with invalid params" do
      it "assigns the <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= stub orm_class.find(class_name) %> { <%= mock_file_name(:update_attributes => false) %> }
        put :update, {:id => "1"}, valid_session
        assigns(:<%= ns_file_name %>).should be(<%= mock_file_name %>)
      end

      it "re-renders the 'edit' template" do
        <%= stub orm_class.find(class_name) %> { <%= mock_file_name(:update_attributes => false) %> }
        put :update, {:id => "1"}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested <%= ns_file_name %>" do
      <%= stub orm_class.find(class_name, "37".inspect) %> { <%= mock_file_name %> }
      mock_<%= should_receive orm_instance.destroy %>
      delete :destroy, {:id => "37"}, valid_session
    end

    it "redirects to the <%= table_name %> list" do
      <%= stub orm_class.find(class_name) %> { <%= mock_file_name %> }
      delete :destroy, {:id => "1"}, valid_session
      response.should redirect_to(<%= index_helper %>_url)
    end
  end

end
<% end -%>
