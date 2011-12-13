###A coffeescript port of 

[https://github.com/zacharyvoase/humanhash](https://github.com/zacharyvoase/humanhash)

### humanhash

humanhash provides human-readable representations of digests.

### Input

	DEFAULT_HASHER = new HumanHasher()
	digest = '7528880a986c40e78c38115e640da2a1'
	console.log DEFAULT_HASHER.humanize(digest)
	console.log DEFAULT_HASHER.humanize(digest, words=6)
	console.log DEFAULT_HASHER.uuid()


### Output

	three-georgia-xray-jig
	high-mango-white-oregon-purple-charlie
	[ 'beryllium-timing-seventeen-sixteen',
	  '37423d5d9a51fdd6d3d29052c91f3f20' ]

To see how this works.

[https://github.com/zacharyvoase/humanhash](https://github.com/zacharyvoase/humanhash)