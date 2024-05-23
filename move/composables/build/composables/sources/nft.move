module composables::nft {
    use std::string::{String, utf8};
    use sui::tx_context::{sender, TxContext};
    use sui::object::{Self, UID};
    use sui::package::{Self};
    use sui::transfer;
    use sui::display;

    struct ComposableNft has key, store {
        id: UID,
        name: String,
        description: String,
        image_url: String,
        type: String,
    }

    struct NFT has drop {}

    struct AdminCap has key, store { id: UID }

    fun init(otw: NFT, ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"id"),
            utf8(b"name"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"type")
        ];

        let values = vector[
            utf8(b"{id}"),
            utf8(b"{name}"),
            utf8(b"{image_url}"),
            utf8(b"{description}"),
            utf8(b"{type}")
        ];

        let publisher = package::claim(otw, ctx);

        let display = display::new_with_fields<ComposableNft>(
            &publisher, keys, values, ctx
        );

        let adminCap = AdminCap {
            id: object::new(ctx)
        };

        display::update_version(&mut display);

        transfer::public_transfer(display, sender(ctx));

        transfer::public_transfer(publisher, sender(ctx));
        
        transfer::transfer(adminCap, sender(ctx));
    }

    public fun mint(
        _: &AdminCap,
        recipient: address,
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
        type: vector<u8>,
        ctx: &mut TxContext
    ) {
        let nft = ComposableNft {
            id: object::new(ctx),
            name: utf8(name),
            description: utf8(description),
            image_url: utf8(image_url),
            type: utf8(type)
        };

        transfer::public_transfer(nft, recipient);
    }

    public fun update(nft: &mut ComposableNft, name: vector<u8>, description: vector<u8>, image_url: vector<u8>) {
        nft.name = utf8(name);
        nft.description = utf8(description);
        nft.image_url = utf8(image_url);
    }

}