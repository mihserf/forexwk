require 'test/unit'
require File.dirname(__FILE__) + "/active_record/testing"

class ActsAsSEOTest < Test::Unit::TestCase
  def setup
    @page = Page.new
  end
  
  def test_if_active_record_has_seo_methods
    assert !TestPage.new.respond_to?(:metatag_title)
  end
  
  def test_should_have_one_metatag
    assert_respond_to(@page, :metatag)
  end
  
  def test_should_have_metatag_virtual_methods
    assert_respond_to(@page, :metatag_title)
    assert_respond_to(@page, :metatag_title=)
    assert_respond_to(@page, :metatag_keywords)
    assert_respond_to(@page, :metatag_keywords=)
    assert_respond_to(@page, :metatag_description)
    assert_respond_to(@page, :metatag_description=)
  end
  
  def test_should_create_a_metatag
    @page.metatag_title = "Testing"
    assert_equal("Testing", @page.metatag_title)
    
    @page.metatag_description = "Object's description."
    assert_equal("Object's description.", @page.metatag_description)
    
    @page.metatag_keywords = "test, testing"
    assert_equal("test, testing", @page.metatag_keywords)
    
    @page.save
    assert_equal("Testing", @page.metatag.title)
    assert_equal("Object's description.", @page.metatag.description)
    assert_equal("test, testing", @page.metatag.keywords)
  end
  
  def test_should_return_all_metatags
    @page = Page.first
    assert_equal([["description", "Object's description."],["keywords", "test, testing"]], @page.metatags)
  end
  
  def test_updating_metatags
    @page = Page.first
    
    @page.metatag_title = "Opa"
    @page.save
    
    assert_equal("Opa", @page.metatag.title)
    
    @page.update_attributes({:metatag_title=>"New Title", :metatag_description=>"A new description"})
    
    assert_equal("New Title", @page.metatag.title)
    assert_equal("A new description", @page.metatag.description)
  end
end
