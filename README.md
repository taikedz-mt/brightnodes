# Bright Nodes for Minetest

A simple mod to brighten lots of nodes in one go

## Use

This mod adds a "brightener" which is made by combining two torches.

You can then combine a brightener with any defined nodes to make a bright version of it

Bright nodes can be crafted back to normal nodes

## Configuration

Determine which mods have nodes you want to brighten - add these mods to the `depends.txt`

Then edit the `items.lua` file -- explicitly add which nodes you want. The entries are Lua-style regular expressions. For example

	{
		"default:sand",
		"default:cobble",
	}

This will only add brigh cobble and bright sand to your world

	{
		"default:desert.*"
	}

This will brighten all desert-related blocks

	{
		"flowers:.*"
	}

This will make bright versions of all the flowers, with some exceptions -- you cannot brighten a waterlily for example, as its `on_place` overrides the placement behaviour.

Some other nodes can't have brightened version made of them, this is still under investigation.
