class ConnectionAlert < SitePrism::Section
  elements :alert_links, ".message p a"
  element :image, ".invitation-icon"
end
