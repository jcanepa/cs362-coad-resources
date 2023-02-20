RSpec.describe Organization, type: :model do
 
  let(:organization) {build(:organization)}
  let(:named_org) {build(:organization, :name => 'name')}
  let(:email_org) {build(:organization, :email => 'name@testing.com')}
  let(:phone_org) {build(:organization, :phone => '555-555-5555S')}
  let(:liability_org) {build(:organization, :liability_insurance => true)}
  let(:primary_name_org) {build(:organization, :primary_name => 'Primary Name')}
  let(:secondary_name_org) {build(:organization, :secondary_name => 'Secondary Name')}
  let(:secondary_phone_org) {build(:organization, :secondary_phone => "555-555-5555")}
  let(:incorrect_email_org) {build(:organization, :email => "notFormattedCorrectly")}
  let(:title_org) {build(:organization, :title => "Title")}
  let(:transport_org) {build(:organization, :transportation => :yes)}
  let(:description_org) {build(:organization, :description => "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
    et dolore magna aliqua. Quam adipiscing vitae proin sagittis nisl rhoncus. Nunc faucibus a pellentesque
    sit amet porttitor eget dolor morbi. Eu non diam phasellus vestibulum lorem sed risus ultricies tristique.
    Eu facilisis sed odio morbi quis commodo odio aenean sed. Aliquam purus sit amet luctus venenatis lectus magna.")}
  let(:status_org) {build(:organization, :status =>1)}
    
    # Test Instantiation
    it "exists" do 
        organization
    end

    # Test Attributtes
    it "has a name" do 
        #org = organization
        expect(named_org).to \
        respond_to(:name)
    end

    it "has an email" do
      expect(email_org).to \
      respond_to(:email)
    end

    it "has a phone number" do
      expect(phone_org).to \
      respond_to(:phone)
    end

    it "has liability insurance" do
      expect(liability_org).to \
      respond_to(:liability_insurance)
    end

    it "has a primary name" do
      expect(primary_name_org).to \
      respond_to(:primary_name)
    end

    it "has a secondary name" do
      expect(secondary_name_org).to \
      respond_to(:secondary_name)
    end

    it "has a title" do
      expect(title_org).to \
      respond_to(:title)
    end

    it "has transportation set" do
      expect(transport_org).to \
      respond_to(:transportation)
    end

    it "has a description" do
      expect(description_org).to \
      respond_to(:description)
    end

    it "has a string representation" do
        expect(named_org.to_s).to eq("name")
    end

    it "has a status" do 
        expect(status_org).to respond_to(:status)
    end

    it "has transportation" do
        expect(transport_org).to \
        respond_to(:transportation)
    end
    
    # Testing functions

    it "has set_default_status" do
        expect(organization).to \
        respond_to(:set_default_status)
    end

    it "set status to approved" do
      expect(organization.approve).to \
      eq(:approved)
    end

    it "set status to rejected" do
      expect(organization.reject).to \
      eq(:rejected)
    end

    it "set default status" do
      expect(organization.set_default_status).to \
      eq("submitted")
    end

    # Test associations

    context "association: has many users" do
        it { should have_many(:users)
          .class_name('User') }
    end

    context "associations: has many tickets" do
      it { should have_many(:tickets)
        .class_name('Ticket')}
    end

    context "associations: belongs to many resource categories" do
      it { should have_and_belong_to_many(:resource_categories)
        .class_name("ResourceCategory")}
    end
    
    # Validators
    it "validates presence of name" do 
      expect(named_org).to \
      validate_presence_of(:name)
    end

    it "verifies the minimum length of name" do
      expect(named_org).to \
      validate_length_of(:name)
      .is_at_least(1)
    end

    it "verfies the maximum length of name" do 
      expect(named_org).to \
      validate_length_of(:name)
      .is_at_most(255)
    end

    it "verifies the uniqueness of name" do
      expect(named_org).to \
      validate_uniqueness_of(:name)
      .ignoring_case_sensitivity
      .on(:create)
    end

    it "validates presence of email" do 
      expect(email_org).to \
      validate_presence_of(:email)
    end

    it "verifies the minimum length of email" do 
      expect(email_org).to \
      validate_length_of(:email)
      .is_at_least(1)
      .on(:create)
    end

    it "verifies the maximum length of an email" do
      expect(email_org).to \
      validate_length_of(:email)
      .is_at_most(255)
      .on(:create)
    end

    it "verifies the uniqueness of an email" do 
      expect(email_org).to \
      validate_uniqueness_of(:email)
      .ignoring_case_sensitivity
    end

    it "verifies email format with regex" do
      expect(email_org.email).to \
      match(Organization::VALID_EMAIL_REGEX)
    end

    it "verifies email incorrect with regex" do 
      expect(incorrect_email_org.email).not_to \
      match(Organization::VALID_EMAIL_REGEX)
    end
    
    it "verifies description max length" do
      expect(description_org).to \
      validate_length_of(:description)
      .is_at_most(1020)
      .on(:create)
    end

    it "verifies the presence of the phone" do 
      expect(phone_org).to \
      validate_presence_of(:phone)
    end

    it "verifies presence of status" do 
      expect(status_org).to \
      validate_presence_of(:status)
    end

    it "verifies the presence of primary_name" do
      expect(primary_name_org).to \
      validate_presence_of(:primary_name)
    end

    it "verifies presence of secondary_name" do 
      expect(secondary_name_org).to \
      validate_presence_of(:secondary_name)
    end

    it "verifies presence of secondary_phone" do
      expect(secondary_phone_org).to \
      validate_presence_of(:secondary_phone)
    end

end