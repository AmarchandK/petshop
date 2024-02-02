class Product {
  List<ProductElement>? products;
  String? count;

  Product({
    this.products,
    this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        products: json["products"] == null
            ? []
            : List<ProductElement>.from(
                json["products"]!.map((x) => ProductElement.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "count": count,
      };
}

class ProductElement {
  String? title;
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? type;
  String? status;
  bool? downloadable;
  bool? virtual;
  String? permalink;
  String? sku;
  String? price;
  String? regularPrice;
  dynamic salePrice;
  String? priceHtml;
  bool? taxable;
  String? taxStatus;
  String? taxClass;
  bool? managingStock;
  dynamic stockQuantity;
  bool? inStock;
  bool? backordersAllowed;
  bool? backordered;
  bool? soldIndividually;
  bool? purchaseable;
  bool? featured;
  bool? visible;
  String? catalogVisibility;
  bool? onSale;
  String? productUrl;
  String? buttonText;
  dynamic weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  dynamic shippingClassId;
  String? description;
  String? shortDescription;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  List<int>? relatedIds;
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  int? parentId;
  List<String>? categories;
  List<dynamic>? tags;
  List<Images>? images;
  String? featuredSrc;
  List<dynamic>? attributes;
  List<dynamic>? downloads;
  int? downloadLimit;
  int? downloadExpiry;
  String? downloadType;
  String? purchaseNote;
  int? totalSales;
  List<dynamic>? variations;
  List<dynamic>? parent;
  List<dynamic>? groupedProducts;
  int? menuOrder;
  int quantity;

  ProductElement({
    this.title,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.status,
    this.downloadable,
    this.virtual,
    this.permalink,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.priceHtml,
    this.taxable,
    this.taxStatus,
    this.taxClass,
    this.managingStock,
    this.stockQuantity,
    this.inStock,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.purchaseable,
    this.featured,
    this.visible,
    this.catalogVisibility,
    this.onSale,
    this.productUrl,
    this.buttonText,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.description,
    this.shortDescription,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.relatedIds,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.categories,
    this.tags,
    this.images,
    this.featuredSrc,
    this.attributes,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.downloadType,
    this.purchaseNote,
    this.totalSales,
    this.variations,
    this.parent,
    this.groupedProducts,
    this.menuOrder,
    this.quantity = 0,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        title: json["title"],
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        type: json["type"],
        status: json["status"],
        downloadable: json["downloadable"],
        virtual: json["virtual"],
        permalink: json["permalink"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        priceHtml: json["price_html"],
        taxable: json["taxable"],
        taxStatus: json["tax_status"],
        taxClass: json["tax_class"],
        managingStock: json["managing_stock"],
        stockQuantity: json["stock_quantity"],
        inStock: json["in_stock"],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        soldIndividually: json["sold_individually"],
        purchaseable: json["purchaseable"],
        featured: json["featured"],
        visible: json["visible"],
        catalogVisibility: json["catalog_visibility"],
        onSale: json["on_sale"],
        productUrl: json["product_url"],
        buttonText: json["button_text"],
        weight: json["weight"],
        dimensions: json["dimensions"] == null
            ? null
            : Dimensions.fromJson(json["dimensions"]),
        shippingRequired: json["shipping_required"],
        shippingTaxable: json["shipping_taxable"],
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        description: json["description"],
        shortDescription: json["short_description"],
        reviewsAllowed: json["reviews_allowed"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        relatedIds: json["related_ids"] == null
            ? []
            : List<int>.from(json["related_ids"]!.map((x) => x)),
        upsellIds: json["upsell_ids"] == null
            ? []
            : List<dynamic>.from(json["upsell_ids"]!.map((x) => x)),
        crossSellIds: json["cross_sell_ids"] == null
            ? []
            : List<dynamic>.from(json["cross_sell_ids"]!.map((x) => x)),
        parentId: json["parent_id"],
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"]!.map((x) => x)),
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"]!.map((x) => x)),
        images: json["images"] == null
            ? []
            : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
        featuredSrc: json["featured_src"],
        attributes: json["attributes"] == null
            ? []
            : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        downloads: json["downloads"] == null
            ? []
            : List<dynamic>.from(json["downloads"]!.map((x) => x)),
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        downloadType: json["download_type"],
        purchaseNote: json["purchase_note"],
        totalSales: json["total_sales"],
        variations: json["variations"] == null
            ? []
            : List<dynamic>.from(json["variations"]!.map((x) => x)),
        parent: json["parent"] == null
            ? []
            : List<dynamic>.from(json["parent"]!.map((x) => x)),
        groupedProducts: json["grouped_products"] == null
            ? []
            : List<dynamic>.from(json["grouped_products"]!.map((x) => x)),
        menuOrder: json["menu_order"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type,
        "status": status,
        "downloadable": downloadable,
        "virtual": virtual,
        "permalink": permalink,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "price_html": priceHtml,
        "taxable": taxable,
        "tax_status": taxStatus,
        "tax_class": taxClass,
        "managing_stock": managingStock,
        "stock_quantity": stockQuantity,
        "in_stock": inStock,
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "sold_individually": soldIndividually,
        "purchaseable": purchaseable,
        "featured": featured,
        "visible": visible,
        "catalog_visibility": catalogVisibility,
        "on_sale": onSale,
        "product_url": productUrl,
        "button_text": buttonText,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "description": description,
        "short_description": shortDescription,
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "related_ids": relatedIds == null
            ? []
            : List<dynamic>.from(relatedIds!.map((x) => x)),
        "upsell_ids": upsellIds == null
            ? []
            : List<dynamic>.from(upsellIds!.map((x) => x)),
        "cross_sell_ids": crossSellIds == null
            ? []
            : List<dynamic>.from(crossSellIds!.map((x) => x)),
        "parent_id": parentId,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "featured_src": featuredSrc,
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x)),
        "downloads": downloads == null
            ? []
            : List<dynamic>.from(downloads!.map((x) => x)),
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "download_type": downloadType,
        "purchase_note": purchaseNote,
        "total_sales": totalSales,
        "variations": variations == null
            ? []
            : List<dynamic>.from(variations!.map((x) => x)),
        "parent":
            parent == null ? [] : List<dynamic>.from(parent!.map((x) => x)),
        "grouped_products": groupedProducts == null
            ? []
            : List<dynamic>.from(groupedProducts!.map((x) => x)),
        "menu_order": menuOrder,
      };
}

class Dimensions {
  String? length;
  String? width;
  String? height;
  String? unit;

  Dimensions({
    this.length,
    this.width,
    this.height,
    this.unit,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "width": width,
        "height": height,
        "unit": unit,
      };
}

class Images {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? src;
  String? title;
  String? alt;
  int? position;

  Images({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.src,
    this.title,
    this.alt,
    this.position,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        src: json["src"],
        title: json["title"],
        alt: json["alt"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "src": src,
        "title": title,
        "alt": alt,
        "position": position,
      };
}
