digest = '60ad8d0d871b6095808297'

DEFAULT_WORDLIST = [
    'ack', 'alabama', 'alanine', 'alaska', 'alpha', 'angel', 'apart', 'april',
    'arizona', 'arkansas', 'artist', 'asparagus', 'aspen', 'august', 'autumn',
    'avocado', 'bacon', 'bakerloo', 'batman', 'beer', 'berlin', 'beryllium',
    'black', 'blossom', 'blue', 'bluebird', 'bravo', 'bulldog', 'burger',
    'butter', 'california', 'carbon', 'cardinal', 'carolina', 'carpet', 'cat',
    'ceiling', 'charlie', 'chicken', 'coffee', 'cola', 'cold', 'colorado',
    'comet', 'connecticut', 'crazy', 'cup', 'dakota', 'december', 'delaware',
    'delta', 'diet', 'don', 'double', 'early', 'earth', 'east', 'echo',
    'edward', 'eight', 'eighteen', 'eleven', 'emma', 'enemy', 'equal',
    'failed', 'fanta', 'fifteen', 'fillet', 'finch', 'fish', 'five', 'fix',
    'floor', 'florida', 'football', 'four', 'fourteen', 'foxtrot', 'freddie',
    'friend', 'fruit', 'gee', 'georgia', 'glucose', 'golf', 'green', 'grey',
    'hamper', 'happy', 'harry', 'hawaii', 'helium', 'high', 'hot', 'hotel',
    'hydrogen', 'idaho', 'illinois', 'india', 'indigo', 'ink', 'iowa',
    'island', 'item', 'jersey', 'jig', 'johnny', 'juliet', 'july', 'jupiter',
    'kansas', 'kentucky', 'kilo', 'king', 'kitten', 'lactose', 'lake', 'lamp',
    'lemon', 'leopard', 'lima', 'lion', 'lithium', 'london', 'louisiana',
    'low', 'magazine', 'magnesium', 'maine', 'mango', 'march', 'mars',
    'maryland', 'massachusetts', 'may', 'mexico', 'michigan', 'mike',
    'minnesota', 'mirror', 'mississippi', 'missouri', 'mobile', 'mockingbird',
    'monkey', 'montana', 'moon', 'mountain', 'muppet', 'music', 'nebraska',
    'neptune', 'network', 'nevada', 'nine', 'nineteen', 'nitrogen', 'north',
    'november', 'nuts', 'october', 'ohio', 'oklahoma', 'one', 'orange',
    'oranges', 'oregon', 'oscar', 'oven', 'oxygen', 'papa', 'paris', 'pasta',
    'pennsylvania', 'pip', 'pizza', 'pluto', 'potato', 'princess', 'purple',
    'quebec', 'queen', 'quiet', 'red', 'river', 'robert', 'robin', 'romeo',
    'rugby', 'sad', 'salami', 'saturn', 'september', 'seven', 'seventeen',
    'shade', 'sierra', 'single', 'sink', 'six', 'sixteen', 'skylark', 'snake',
    'social', 'sodium', 'solar', 'south', 'spaghetti', 'speaker', 'spring',
    'stairway', 'steak', 'stream', 'summer', 'sweet', 'table', 'tango', 'ten',
    'tennessee', 'tennis', 'texas', 'thirteen', 'three', 'timing', 'triple',
    'twelve', 'twenty', 'two', 'uncle', 'undress', 'uniform', 'uranus', 'utah',
    'vegan', 'venus', 'vermont', 'victor', 'video', 'violet', 'virginia',
    'washington', 'west', 'whiskey', 'white', 'william', 'winner', 'winter',
    'wisconsin', 'wolfram', 'wyoming', 'xray', 'yankee', 'yellow', 'zebra',
    'zulu']

class HumanHasher
    constructor: (wordlist=DEFAULT_WORDLIST) ->
        if wordlist.length != 256
            throw "Wordlist must have exactly 256 items"
        @wordlist = wordlist

    bytes = (digest) ->
        zips = []
        for el, i in digest
            if i != (digest.length - 1) and i%2==0
                zips.push([digest[i], digest[i+1]])
        (parseInt(el.join(''), 16) for el in zips)


    xor = (iterable) ->
        start = 0
        for el in iterable
            start ^= el
        return start

    compress = (bytes, target) ->
        seg_size = parseInt(bytes.length / target)
        segments = (bytes[i*seg_size...(i+1)*seg_size] for i in [0...target])
        last = segments[target-1]
        last.push.apply(last, bytes[target*seg_size..])
        segments = (xor(el) for el in segments)
        return segments
    

    S4 = -> 
        return (((1+Math.random())*0x10000)|0).toString(16).substring(1)

    uid = ->
        return (S4()+S4()+""+S4()+""+S4()+""+S4()+""+S4()+S4()+S4())
       
        
    
    humanize: (hexdigest, words=4, separator='-') ->
        in_bytes = bytes(hexdigest)
        compressed = compress(in_bytes, words)
        return (@wordlist[el] for el in compressed).join("-")
        
    uuid: ->
        digest = uid()
        [(@humanize digest), digest]
    



DEFAULT_HASHER = new HumanHasher()
digest = '7528880a986c40e78c38115e640da2a1'
console.log DEFAULT_HASHER.humanize(digest)
console.log DEFAULT_HASHER.humanize(digest, words=6)
console.log DEFAULT_HASHER.uuid()