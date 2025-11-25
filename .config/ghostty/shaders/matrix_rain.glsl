// Ghostty custom shader: Subtle Matrix rain with interleaved glyph streams
// Author: ChatGPT (public domain / CC0)

const int GLYPH_COUNT = 12;
const float GLYPH_TABLE[GLYPH_COUNT * 7] = float[](
    // 0
    14.0, 17.0, 21.0, 21.0, 21.0, 17.0, 14.0,
    // 1
    4.0, 12.0, 4.0, 4.0, 4.0, 4.0, 14.0,
    // 2
    14.0, 17.0, 1.0, 2.0, 4.0, 8.0, 31.0,
    // 3
    14.0, 17.0, 1.0, 6.0, 1.0, 17.0, 14.0,
    // 4
    2.0, 6.0, 10.0, 18.0, 31.0, 2.0, 2.0,
    // 5
    31.0, 16.0, 30.0, 1.0, 1.0, 17.0, 14.0,
    // カ
    14.0, 4.0, 12.0, 4.0, 4.0, 4.0, 4.0,
    // ナ
    14.0, 4.0, 4.0, 31.0, 4.0, 4.0, 4.0,
    // ヨ
    31.0, 4.0, 4.0, 31.0, 4.0, 4.0, 31.0,
    // ホ
    17.0, 17.0, 31.0, 4.0, 31.0, 17.0, 17.0,
    // ツ
    4.0, 4.0, 4.0, 31.0, 10.0, 10.0, 17.0,
    // ロ
    31.0, 17.0, 17.0, 17.0, 17.0, 17.0, 31.0
);

const vec2 CELL_SIZE = vec2(18.0, 27.0);

float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

float glyphPattern(vec2 cellUV, float glyphIndex) {
    vec2 sub = floor(cellUV * vec2(5.0, 7.0));
    if (sub.x >= 5.0 || sub.y >= 7.0) {
        return 0.0;
    }

    int glyph = int(mod(glyphIndex, float(GLYPH_COUNT)));
    int row = int(sub.y);
    int idx = glyph * 7 + row;
    float bits = GLYPH_TABLE[idx];

    float shift = pow(2.0, 4.0 - sub.x);
    float bit = floor(mod(floor(bits / shift), 2.0));
    return bit;
}

vec3 rainContribution(vec2 fragCoord, vec2 offset) {
    vec2 shifted = (fragCoord + offset) / CELL_SIZE;
    vec2 cellIndex = floor(shifted);
    vec2 cellUV = fract(shifted);

    float totalRows = max(1.0, floor(iResolution.y / CELL_SIZE.y));

    float columnSeed = hash(vec2(cellIndex.x + offset.x * 0.1, 37.0));
    float speed = mix(0.05, 0.14, columnSeed);
    float time = iTime * speed + columnSeed * 4.0;

    float headRow = mod(time * totalRows, totalRows);
    float row = cellIndex.y;
    float dist = row - headRow;
    if (dist < 0.0) {
        dist += totalRows;
    }

    const float maxTrailRows = 16.0;
    float trailWindow = smoothstep(maxTrailRows, 0.0, dist);
    float falloff = exp(-dist * 0.2);
    float trail = trailWindow * falloff;

    float glyphSeed = floor(iTime * 1.5 + columnSeed * 14.0 + offset.x * 0.25);
    float glyphIndex = floor(hash(cellIndex + vec2(glyphSeed, offset.x * 0.17)) * float(GLYPH_COUNT));
    float glyph = glyphPattern(cellUV, glyphIndex);

    float headGlow = smoothstep(1.35, 0.0, dist) * glyph;

    vec3 tailColor = vec3(0.0, 0.55, 0.18) * glyph * trail * 0.12;
    vec3 leadColor = vec3(0.35, 0.78, 0.5) * headGlow * 0.2;

    return tailColor + leadColor;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 baseColor = texture(iChannel0, uv);

    vec3 contribution = rainContribution(fragCoord, vec2(0.0, 0.0));
    contribution += rainContribution(fragCoord, vec2(CELL_SIZE.x * 0.5, CELL_SIZE.y * 0.5));
    contribution *= 0.75;

    vec3 tinted = mix(baseColor.rgb, baseColor.rgb + vec3(0.0, 0.02, 0.0), 0.04);
    vec3 color = tinted + contribution;

    fragColor = vec4(clamp(color, 0.0, 1.0), baseColor.a);
}
