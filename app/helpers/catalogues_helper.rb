module CataloguesHelper
  def catalogue_menu
    render :partial => "catalogues/catalogue_menu", :locals => {:items => Catalogue.roots}
  end

  def sub_catalogues(catalogue)
    catalogues = catalogue.nil? ? Catalogue.roots : catalogue.children
    render :partial => "catalogues/sub_catalogues", :locals => {:items => catalogues}
  end

  def catalogue_breadcrumbs
    catalogues = @catalogue.nil? ? [] : @catalogue.self_and_ancestors
    render :partial => "catalogues/breadcrumbs", :locals => { :items => catalogues }
  end
end
