module CataloguesHelper
  def catalogue_menu
    render :partial => "catalogues/catalogue_menu", :locals => {:items => Catalogue.roots}
  end

  def sub_catalogues(catalogue)
    render :partial => "catalogues/sub_catalogues", :locals => {:items => catalogue.children}
  end
end
