require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
   test "the truth" do
     assert true
   end
		
	 test 'open project and create new sponsor' do
		 assert_difference ('Project.count') {
		 	 post '/projects/', project: {title: 'new project', body: 'body of new project', target: '1000.00'}	 #target added
		   assert_response :redirect
			 follow_redirect!
			 assert_response :success
			}

		 if Project.all!=[] 
		   get '/projects/new'
			 assert_response :success
		
			 post '/projects/1/sponsors', sponsor: {project_id: '1', name: 'good sponsor', amount: '50.0'}
		   assert_response :redirect
			 follow_redirect!
			 assert_response :success
		 end
	 end

	 test "Amount entered in sponsor is integer" do
		 get '/sponsors/new'
		 assert_response :success
		 post '/sponsors/', sponsor: {project_id: '1', name: 'big sponsor', amount: 'big money'}
		 assert_response :success
		 assert response.body.include?('is not a number')
	 end

	 test "Sponsor for non existant project should not be added " do
	   invalid_p_id = 1
	   while Project.exists?(invalid_p_id) == true
       invalid_p_id+=1
     end
	   #assert_not_includes( Project, Project.where(Project id => 1), "invalid project present" )
	   #puts Project.where(Project id => 1).exists?
		 #assert_raise('Project with this project_id does not exist') {
		 post '/sponsors/', sponsor: {project_id: invalid_p_id, name: 'bad sponsor', amount: '1000.00'}
		 }
	 end

   test "test1" do
	 
   assert_raise(ActiveRecord::RecordNotFound) {
   get '/sponsors/25'}
   assert_raise(ActiveRecord::RecordNotFound) {
   get '/projects/25'}
	
   end

   test 'delete project and check count difference' do
     get '/projects/1'
     puts 'pcount old:',Project.count
		 assert_difference('Project.count',difference = -1, message = nil) {
		 	 delete '/projects/1'
       puts 'pcount:',Project.count
		   assert_response :redirect
			 follow_redirect!
			 assert_response :success
			}
     
   end
	
end


